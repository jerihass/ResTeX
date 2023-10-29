//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentKeys: String, CodingKey {
    case node
    case wire
    case resistor
}

protocol Component: Codable, Sendable {
    var id: UUID { get }
    mutating func move(_ location: CGPoint)
    var origin: CGPoint { get }
    var key: ComponentKeys { get }
    var selected: Bool { get set }
}

struct Node: Component {
    var id = UUID()
    var radius: Float
    var origin: CGPoint
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
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var key: ComponentKeys { .wire }
}

struct Resistor: Component {
    var id = UUID()
    var start: CGPoint
    var vertical: Bool? = false
    var selected: Bool = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var key: ComponentKeys { .resistor }
}


