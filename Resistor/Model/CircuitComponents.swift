//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

protocol CircuitCodable: Codable {}

struct Circuit {
    var components: [CircuitCodable]

    init(components: [CircuitCodable] = []) {
        self.components = components
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

