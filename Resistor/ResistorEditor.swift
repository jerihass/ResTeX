//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var items: [CircuitComponent]
    var body: some View {
        ZStack {
            ForEach(items) { item in
                item.draw()
            }
        }
    }
}

protocol CircuitShape: Shape, Identifiable {}

struct CircuitComponent: Identifiable {
    var id = UUID()
    var circuitShape: any CircuitShape
    var fill: Bool = true
    func draw(in rect: CGRect = .infinite) -> some View {
        return makeBody()
    }

    @ViewBuilder
    private func makeBody() -> some View {
        if fill {
            circuitShape.path(in: .infinite).fill()
        } else {
            circuitShape.path(in: .infinite).stroke(lineWidth: 2.0)
        }
    }
}

struct Point {
    var radius: Float
    var origin: CGPoint
}

struct Line {
    var start: CGPoint
    var end: CGPoint
}

struct NodeShape: CircuitShape {
    var id = UUID()
    var point: Point
    func path(in rect: CGRect = .infinite) -> Path {
        var path = Path()
        
        path.addArc(center: point.origin,
                 radius: CGFloat(point.radius),
                 startAngle: .zero,
                 endAngle: .degrees(360),
                 clockwise: true)
        path.closeSubpath()
        
        return path
    }
}

struct ShortShape: CircuitShape {
    var id = UUID()
    var line: Line
    var thickness: Int = 1
    func path(in rect: CGRect = .infinite) -> Path {

        var path = Path()
        path.addLine(to: .zero)
        path.move(to: line.start)
        path.addLine(to: line.end)
        path.closeSubpath()
        
        return path
    }
}

struct ResistorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        return path
    }
}

#Preview {
    let node1 = NodeShape(point: .init(radius: 5, origin: .init(x: 40, y: 20)))
    let short1 = ShortShape(line: .init(start: .init(x: 2, y: 3), end: .init(x: 50, y: 3)))
    let node2 = NodeShape(point: .init(radius: 12, origin: .init(x: 60, y: 200)))
    return ResistorEditor(items: [.init(circuitShape: node1), .init(circuitShape: short1, fill: false), .init(circuitShape: node2)])
}
