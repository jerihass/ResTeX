//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

protocol Component: Codable, Sendable {
    var id: UUID { get }
    mutating func move(_ location: CGPoint)
    var origin: CGPoint { get }
}

struct Node: Component {
    var id = UUID()
    var radius: Float
    var origin: CGPoint
    mutating func move(_ location: CGPoint) {
        origin = location
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
}

struct Resistor: Component {
    var id = UUID()
    var start: CGPoint
    var vertical: Bool? = false
    mutating func move(_ location: CGPoint) {
        start = location
    }
    var origin: CGPoint { start }
}


