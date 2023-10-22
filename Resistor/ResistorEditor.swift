//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var items: [any CircuitShape]
    var body: some View {
        ZStack {
            items[0].path(in: .infinite)
            items[1].path(in: .infinite)
            items[2].path(in: .infinite)
        }
    }
}

protocol CircuitShape: Shape, Identifiable {}

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
    func path(in rect: CGRect = .infinite) -> Path {
        var path = Path()

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
    ResistorEditor(items: [NodeShape(point: .init(radius: 5, origin: .init(x: 40, y: 20))),
                           ShortShape(line: .init(start: .init(x: 2, y: 3), end: .init(x: 5, y: 9))),
                           NodeShape(point: .init(radius: 12, origin: .init(x: 60, y: 200)))])
}
