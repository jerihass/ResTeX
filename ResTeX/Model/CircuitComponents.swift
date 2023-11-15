//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentKeys: String, CodingKey, CaseIterable {
    case node
    case wire
    case resistor
    case capacitor

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
        case .capacitor:
            guard let cap = component as? Capacitor else { return nil }
            return ComponentEnum.capacitor(cap)
        }
    }
}

protocol Component: Codable, Sendable {
    var id: UUID { get }
    var label: String { get set }
    mutating func move(_ location: CGPoint)
    var origin: CGPoint { get }
    var rect: CGRect { get }
    var vertical: Bool { get set }
    var key: ComponentKeys { get }
    var selected: Bool { get set }
}

struct Node: Component {
    var id = UUID()
    var label: String = ""
    var radius: Float
    var origin: CGPoint
    var rect: CGRect {
        let x = origin.x
        let y = origin.y
        let width: CGFloat = CGFloat(radius * 2 < 5 ? 5 : radius * 2)
        let height = CGFloat(radius * 2 < 5 ? 5 : radius * 2)
        return .init(x: x, y: y, width: width, height: height)
    }
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        origin = location
    }
    var key: ComponentKeys { .node }
}

struct Wire: Component {
    var id = UUID()
    var label: String = ""
    var start: CGPoint
    var length: CGFloat
    var vertical: Bool = false
    var selected: Bool = false
    var endPoints: EndPoints = EndPoints()
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var rect: CGRect {
        let x = origin.x
        let y = origin.y
        let width = CGFloat(vertical ? 3 : length)
        let height = CGFloat(vertical ? length : 3)
        return .init(x: x, y: y, width: width, height: height)
    }
    var key: ComponentKeys { .wire }

    struct EndPoints: Codable {
        var leading: Bool = false
        var trailing: Bool = false
    }
}

struct Resistor: Component {
    var id = UUID()
    var label: String = "R"
    var start: CGPoint
    var length: CGFloat = 40
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var rect: CGRect {
        let x = origin.x
        let y = origin.y
        let width = CGFloat(vertical ? 3 : 36)
        let height = CGFloat(vertical ? 36 : 3)
        return .init(x: x, y: y, width: width, height: height)
    }
    var key: ComponentKeys { .resistor }
}

struct Capacitor: Component {
    var id: UUID = UUID()
    var label: String = "C"
    var start: CGPoint
    var length: CGFloat = 10
    var origin: CGPoint { start }
    var vertical: Bool = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var rect: CGRect {
        let x = origin.x
        let y = origin.y
        let width = CGFloat(6)
        let height = CGFloat(17)
        return .init(x: x, y: y, width: width, height: height)
    }
    var key: ComponentKeys { .capacitor }
}
