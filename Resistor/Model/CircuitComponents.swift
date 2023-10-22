//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

protocol CircuitCodable: Codable {}

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

