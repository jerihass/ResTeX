//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentEnum: Codable {
    case node(Node)
    case wire(Wire)
    case resistor(Resistor)
}

extension Circuit: Codable {
    enum CodingKeys: String, CodingKey {
        case components
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var componentContainer = container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
//        var componentContainer = container.nestedUnkeyedContainer(forKey: .components)
        for key in ComponentKeys.allCases {
            let sameComps = components.compactMap({ component in
                component.key == key ? key.magic(component) : nil
            })
            try componentContainer.encode(sameComps, forKey: key)
//            try componentContainer.encode(sameComps)
        }
    }

    init(from decoder: Decoder) throws {
        var components = [Component]()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentContainer = try container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        for key in ComponentKeys.allCases {
            let things = try componentContainer.decode([ComponentEnum].self, forKey: key)
            print(things)
            if !things.isEmpty {
                for thing in things {
                    switch thing {
                    case .node(let node):
                        components.append(node)
                    case .wire(let wire):
                        components.append(wire)
                    case .resistor(let resistor):
                        components.append(resistor)
                    }
                }
            }
        }


        self = Circuit(components: components)
    }
}
