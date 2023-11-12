//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

protocol CircuitShape: Shape, Identifiable {
    var origin: CGPoint { get }
    var isSelected: Bool { get set }
    var component: Component { get }
    var vertical: Bool { get }
    var filled: Bool { get }
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
        if circuitShape.filled {
            circuitShape.path(in: .infinite).stroke(lineWidth: 1.0)
        } else {
            circuitShape.path(in: .infinite).stroke(lineWidth: 1.0)
        }
    }
}

struct NodeShape: CircuitShape {
    var id = UUID()
    var node: Node
    var isSelected: Bool = false
    var component: Component { node }
    var vertical: Bool = false
    var filled: Bool = true
    func path(in rect: CGRect = .infinite) -> Path {
        let path = Path(circleCenteredAt: node.origin, radius: CGFloat(node.radius))
        return path
    }

    var origin: CGPoint { node.origin }
}

struct WireShape: CircuitShape {
    var id = UUID()
    var wire: Wire
    var isSelected: Bool = false
    var component: Component { wire }
    var vertical: Bool { component.vertical }
    var filled: Bool = true
    var thickness: Int = 1
    func path(in rect: CGRect = .infinite) -> Path {


        var wirePath = Path()
        wirePath.move(to: wire.start)

        if wire.vertical {
            wirePath.addLine(to: CGPoint(x: wire.start.x, y: wire.start.y + wire.length))
        } else {
            wirePath.addLine(to: CGPoint(x: wire.start.x + wire.length, y: wire.start.y))
        }
        wirePath.closeSubpath()

        let fullPath: CGMutablePath = CGMutablePath()
        fullPath.addPath(wirePath.cgPath)

        if wire.endPoints.leading {
            let leadingNode = Path(circleCenteredAt: wire.start, radius: 2)
            fullPath.addPath(leadingNode.cgPath)
        }

        if wire.endPoints.trailing {
            let trailingNode = wire.vertical ?
            Path(circleCenteredAt: .init(x: wire.start.x, y: wire.start.y + wire.length), radius: 2) :
            Path(circleCenteredAt: .init(x: wire.start.x + wire.length, y: wire.start.y), radius: 2)

            fullPath.addPath(trailingNode.cgPath)
        }

        return Path(fullPath)
    }

    var origin: CGPoint { wire.start }
}

extension Path {
    init(circleCenteredAt: CGPoint, radius: CGFloat) {
        var path = Path()
        path.addArc(center: circleCenteredAt, radius: radius, startAngle: .degrees(0), endAngle:.degrees(360), clockwise: true)
        self = path
    }
}

struct ResistorShape: CircuitShape {
    var id = UUID()
    var resistor: Resistor
    var isSelected: Bool = false
    var length: Int = 40
    var width: Int = 6
    var component: Component { resistor }
    var vertical: Bool { component.vertical }
    var filled: Bool = false

    private var points: [CGPoint]
    init(resistor: Resistor) {
        self.resistor = resistor
        self.length = Int(resistor.length)
        let bodyLength = 36
        let leadLength = (length - bodyLength) / 2
        let zigLength = length - 2 * leadLength
        let fullZigLength = zigLength / 6
        let halfZigLength = fullZigLength / 2

        points = [.init(x: 0, y: 0),
                  .init(x: leadLength, y: 0),
                  .init(x: leadLength + halfZigLength, y: -width),
                  .init(x: leadLength + halfZigLength + 1*fullZigLength, y: width),
                  .init(x: leadLength + halfZigLength + 2*fullZigLength, y: -width),
                  .init(x: leadLength + halfZigLength + 3*fullZigLength, y: width),
                  .init(x: leadLength + halfZigLength + 4*fullZigLength, y: -width),
                  .init(x: leadLength + halfZigLength + 5*fullZigLength, y: width),
                  .init(x: length - leadLength, y: 0),
                  .init(x: length, y: 0),
        ]
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: resistor.start)
        for point in points {
            if !vertical {
                path.addLine(to: .init(x: resistor.start.x + point.x, y: resistor.start.y + point.y))
            } else {
                // The x = start.x - point.y is due to the way the LaTeX resistors are drawn,
                path.addLine(to: .init(x: resistor.start.x - point.y, y: resistor.start.y + point.x))
            }
        }
        path.move(to: resistor.start)
        path.closeSubpath()
        return path
    }

    var origin: CGPoint { resistor.start }
}
