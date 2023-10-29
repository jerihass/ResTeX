//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation

enum ComponentEnum: Codable {
    case point(Node)
    case line(Wire)
    case resistor(Resistor)
}

extension Circuit: Codable {
    enum CodingKeys: String, CodingKey {
        case components
        case type
        case circuit
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var compContiner = container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        for component in self.components {
            try compContiner.encode(component, forKey: component.key)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentContainer = try container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        var components = [Component]()
        for key in componentContainer.allKeys {
            switch key {
            case .node:
                components.append(try componentContainer.decode(Node.self, forKey: .node))
            case .wire:
                components.append(try componentContainer.decode(Wire.self, forKey: .wire))
            case .resistor:
                components.append(try componentContainer.decode(Resistor.self, forKey: .resistor))
            }
        }

        self = Circuit(components: components)
    }
}
