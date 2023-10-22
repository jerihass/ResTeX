//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var items: [CircuitComponent] = [CircuitComponent]()

    init(circuit: Circuit) {
        for item in circuit.components {
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

struct Circuit: Codable {
    var components: [CircuitCodable]

    init(components: [CircuitCodable] = []) {
        self.components = components
    }

    enum CodingKeys: String, CodingKey {
        case components
        case type
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var enums = [CircuitComponentEnum]()
        for component in components {
            if component is Point {
                enums.append(.point(component as! Point))
            }
            if component is Line {
                enums.append(.line(component as! Line))
            }
        }
        try container.encode(enums, forKey: CodingKeys.components)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([CircuitComponentEnum].self, forKey: CodingKeys.components)
        var comps = [CircuitCodable]()
        for item in items {
            switch item {
            case .point(let p):
                comps.append(p)
            case .line(let l):
                comps.append(l)
            }
        }
        self.init(components: comps)
    }
}

enum CircuitComponentEnum {
    case point(Point)
    case line(Line)
}

extension CircuitComponentEnum: Codable {}

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
    return ResistorEditor(circuit: Circuit(components: [Point(radius: 5, origin: .zero),
                                  Line(start: .init(x: 60, y: 75), end: .init(x: 175, y: 300)),
                                  Point(radius: 10, origin: .init(x: 150, y: 350))]))
}
