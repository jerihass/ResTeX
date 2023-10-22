//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var items: [CircuitComponent] = [CircuitComponent]()

    init(items: [CircuitCodable]) {
        for item in items {
            print(item)
            if item is Point {
                self.items.append(.init(circuitShape: NodeShape(point: item as! Point)))
            }
            if item is Line {
                self.items.append(.init(circuitShape: ShortShape(line: item as! Line)))
            }
        }
    }

    var body: some View {
        ZStack {
            ForEach(items) { item in
                item.draw()
            }
        }
    }
}

protocol CircuitShape: Shape, Identifiable {}
protocol CircuitCodable: Codable {}

struct CircuitComponent: Identifiable {
    var id = UUID()
    var circuitShape: any CircuitShape
    var fill: Bool = false
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

struct Point: CircuitCodable {
    var radius: Float
    var origin: CGPoint
}

struct Line : CircuitCodable {
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
    return ResistorEditor(items: [Point(radius: 5, origin: .zero),
                                  Line(start: .init(x: 60, y: 75), end: .init(x: 175, y: 300)),
                                  Point(radius: 10, origin: .init(x: 150, y: 350))])
}
