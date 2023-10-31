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
//        var componentContainer = container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
        var componentContainer = container.nestedUnkeyedContainer(forKey: .components)
        for key in ComponentKeys.allCases {
            let sameComps = components.compactMap({ component in
                component.key == key ? key.magic(component) : nil
            })
//            try componentContainer.encode(sameComps, forKey: key)
            try componentContainer.encode(sameComps)
        }



//        var compContiner = container.nestedContainer(keyedBy: ComponentKeys.self, forKey: .components)
//        for component in self.components {
//            print("Component: \(component)")
//            try compContiner.encode(component, forKey: component.key)
//        }
//        print("Container: \(compContiner)")
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var compContainer = try container.nestedUnkeyedContainer(forKey: .components)

        let comps = [Component]()
        while !compContainer.isAtEnd {
            let comp = try compContainer.decodeIfPresent(Node.self)
        }

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
