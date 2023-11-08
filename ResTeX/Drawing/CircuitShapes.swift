//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

protocol CircuitShape: Shape, Identifiable {
    var origin: CGPoint { get }
    var isSelected: Bool { get set }
    var component: Component { get }
    var vertical: Bool { get }
}

struct ComponentPresenter: Identifiable {
    var id = UUID()
    var circuitShape: any CircuitShape
    var fill: Bool = false
    var selected: Bool = false
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

struct NodeShape: CircuitShape {
    var id = UUID()
    var node: Node
    var isSelected: Bool = false

    var component: Component { node }
    var vertical: Bool = false
    func path(in rect: CGRect = .infinite) -> Path {
        var path = Path()

        path.addArc(center: node.origin,
                 radius: CGFloat(node.radius),
                 startAngle: .zero,
                 endAngle: .degrees(360),
                 clockwise: true)
        path.closeSubpath()

        return path
    }

    var origin: CGPoint { node.origin }
}

struct WireShape: CircuitShape {
    var id = UUID()
    var line: Wire
    var isSelected: Bool = false

    var component: Component { line }
    var vertical: Bool { component.vertical }
    var thickness: Int = 1
    func path(in rect: CGRect = .infinite) -> Path {

        var path = Path()
        path.move(to: line.start)
        if line.vertical {
            path.addLine(to: CGPoint(x: line.start.x, y: line.start.y + line.length))
        } else {
            path.addLine(to: CGPoint(x: line.start.x + line.length, y: line.start.y))
        }
        path.closeSubpath()

        return path
    }

    var origin: CGPoint { line.start }
}

struct ResistorShape: CircuitShape {
    var id = UUID()
    var resistor: Resistor
    var isSelected: Bool = false
    var length: Int = 40
    var width: Int = 6
    var step: Int = 12
    var component: Component { resistor }
    var vertical: Bool { component.vertical }

    private var points: [CGPoint]
    init(resistor: Resistor) {
        self.resistor = resistor

        step = length / step

        points = [.init(x: 0, y: 0),
                  .init(x: step, y: 0),
                  .init(x: step*2, y: -width),
                  .init(x: step*4, y: width),
                  .init(x: step*6, y: -width),
                  .init(x: step*8, y: width),
                  .init(x: step*10, y: -width),
                  .init(x: step*12, y: width),
                  .init(x: step*13, y: 0),
                  .init(x: step*14, y: 0)
        ]
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: resistor.start)
        for point in points {
            if !vertical {
                path.addLine(to: .init(x: resistor.start.x + point.x, y: resistor.start.y + point.y))
            } else {
                path.addLine(to: .init(x: resistor.start.x + point.y, y: resistor.start.y + point.x))
            }
        }
        path.move(to: resistor.start)
        path.closeSubpath()
        return path
    }

    var origin: CGPoint { resistor.start }
}
