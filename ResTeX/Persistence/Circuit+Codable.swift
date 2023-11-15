//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentEnum: Codable {
    case node(Node)
    case wire(Wire)
    case resistor(Resistor)
    case capacitor(Capacitor)

    var component: Component? {
        var comp: Component?
        switch self {
        case .node(let node):
            comp = node
        case .wire(let wire):
            comp = wire
        case .resistor(let resistor):
            comp = resistor
        case .capacitor(let capacitor):
            comp = capacitor
        }
        return comp
    }
}

extension Circuit: Codable {
    enum CodingKeys: String, CodingKey {
        case components
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var componentContainer = container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        for key in ComponentKeys.allCases {
            let sameComps = components.compactMap({ component in
                component.key == key ? key.magic(component) : nil
            })
            try componentContainer.encode(sameComps, forKey: key)
        }
    }
    
    init(from decoder: Decoder) throws {
        var components = [Component]()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentContainer = try container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        for key in ComponentKeys.allCases {
            let things = try componentContainer
                .decode([ComponentEnum].self, forKey: key)
                .compactMap({ $0.component })
            for thing in things {
                components.append(thing)
            }
        }
        self = Circuit(components: components)
    }
}
