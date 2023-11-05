//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentKeys: String, CodingKey, CaseIterable {
    case node
    case wire
    case resistor
    func magic(_ component: Component) -> ComponentEnum? {
        switch self {
        case .node:
            guard let node = component as? Node else { return nil }
            return ComponentEnum.node(node)
        case .wire:
            guard let wire = component as? Wire else { return nil }
            return ComponentEnum.wire(wire)
        case .resistor:
            guard let res = component as? Resistor else { return nil }
            return ComponentEnum.resistor(res)
        }
    }
}

protocol Component: Codable, Sendable {
    var id: UUID { get }
    mutating func move(_ location: CGPoint)
    var origin: CGPoint { get }
    var vertical: Bool { get set }
    var key: ComponentKeys { get }
    var selected: Bool { get set }
}

struct Node: Component {

    var id = UUID()
    var radius: Float
    var origin: CGPoint
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        origin = location
    }
    var key: ComponentKeys { .node }
}

struct Wire: Component {
    var id = UUID()
    var start: CGPoint
    var end: CGPoint
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        let dX = start.x - location.x
        let dY = start.y - location.y
        start = location
        end = .init(x: end.x - dX, y: end.y - dY)
    }
    var origin: CGPoint { start }
    var key: ComponentKeys { .wire }
}

struct Resistor: Component {
    var id = UUID()
    var start: CGPoint
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var key: ComponentKeys { .resistor }
}


