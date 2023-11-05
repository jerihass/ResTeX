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
        let snapX: Int = 5
        let snapY: Int = 5

        let dX = Int(newPoint.x) % snapX
        let dY = Int(newPoint.y) % snapY
        let newX = Int(Int(newPoint.x) - dX)
        let newY = Int(Int(newPoint.y) - dY)
        let snapPoint = CGPoint(x: newX, y: newY)

        guard var component = components.first(where: { $0.id == component.id }) else { return }
        guard let index = components.firstIndex(where: { $0.id == component.id }) else { return }
        components.removeAll(where: {$0.id == component.id})
        component.move(snapPoint)
        components.insert(component, at: index)
    }

    mutating func selectComponent(_ component: Component) {
        guard var component = components.first(where: { $0.id == component.id }) else { return }
        guard let index = components.firstIndex(where: { $0.id == component.id }) else { return }
        components.removeAll(where: {$0.id == component.id})
        component.selected.toggle()
        components.insert(component, at: index)
    }

    mutating func deselectAll() {
        var components = [Component]()
        for component in self.components {
            var comp = component
            comp.selected = false
            components.append(comp)
        }
        self.components = components
    }

    var presenter: [ComponentPresenter] {
        components.compactMap({
            guard let shape = $0 as? ComponentShape else { return nil }
            return ComponentPresenter(circuitShape: shape.shape, selected: $0.selected)
        })
    }

    var shapes: [ComponentShape] {
        components.compactMap({
            return $0 as? ComponentShape
        })
    }

    private mutating func modifyComponent(_ component: Component, modification: (Component) -> Void) {
        guard let component = components.first(where: { $0.id == component.id }) else { return }
        guard let index = components.firstIndex(where: { $0.id == component.id }) else { return }
        components.removeAll(where: {$0.id == component.id})

        modification(component)

        components.insert(component, at: index)
    }
}

extension Circuit {
    static var demo: Circuit {
        let node = Node(radius: 5, origin: .init(x: 20, y: 20))
        let wire = Wire(start: .init(x: 20, y: 20), end: .init(x: 30, y: 20))
        let resistor = Resistor(start: .init(x: 30, y: 20))
        let wire2 = Wire(start: .init(x: 66, y: 20), end: .init(x: 76, y: 20))
        return Circuit(components: [node, wire, resistor, wire2])
    }
}
