//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

protocol Component: Codable, Sendable {
    var id: UUID { get }
    mutating func move(_ location: CGPoint)
    var origin: CGPoint { get }
    var shape: any CircuitShape { get }
}

struct Node: Component {
    var id = UUID()
    var radius: Float
    var origin: CGPoint
    mutating func move(_ location: CGPoint) {
        origin = location
    }

    var shape: any CircuitShape {
        NodeShape(point: self)
    }
}

struct Wire: Component {
    var id = UUID()
    var start: CGPoint
    var end: CGPoint
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var shape: any CircuitShape {
        WireShape(line: self)
    }
}

struct Resistor: Component {
    var id = UUID()
    var start: CGPoint
    var vertical: Bool? = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
    var shape: any CircuitShape {
        ResistorShape(resistor: self, vertical: self.vertical ?? false)
    }
}


