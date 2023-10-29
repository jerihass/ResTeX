//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

struct Circuit: Sendable {
    var components: [Component]
    init(components: [Component] = []) {
        self.components = components
    }
}

extension Circuit {
    mutating func moveComponent(_ component: Component, to newPoint: CGPoint) {
        guard var component = components.first(where: { $0.id == component.id }) else { return }
        guard let index = components.firstIndex(where: { $0.id == component.id }) else { return }
        components.removeAll(where: {$0.id == component.id})
        component.move(newPoint)
        components.insert(component, at: index)
    }

    var presenter: [ComponentPresenter] {
        components.compactMap({
            guard let shape = $0 as? ComponentShape else { return nil }
            return ComponentPresenter(circuitShape: shape.shape)
        })
    }
}
