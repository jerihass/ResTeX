//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentEnum {
    case point(Node)
    case line(Wire)
    case resistor(Resistor)
}

extension ComponentEnum: Codable {}

extension Circuit: Codable {
    enum CodingKeys: String, CodingKey {
        case components
        case type
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var enums = [ComponentEnum]()
        for component in components {
            if component is Node {
                enums.append(.point(component as! Node))
            }
            if component is Wire {
                enums.append(.line(component as! Wire))
            }
            if component is Resistor {
                enums.append(.resistor(component as! Resistor))
            }
        }
        try container.encode(enums, forKey: CodingKeys.components)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let items = try container.decode([ComponentEnum].self, forKey: CodingKeys.components)
        var comps = [Component]()
        for item in items {
            switch item {
            case .point(let p):
                comps.append(p)
            case .line(let l):
                comps.append(l)
            case .resistor(let r):
                comps.append(r)
            }
        }
        self.init(components: comps)
    }
}
