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
        let snapPoint = snapToClosest(snapX: 5, snapY: 5, point: newPoint)
        modifyComponent(component, modification: { move(snapPoint, $0) })
    }

    mutating func selectComponent(_ component: Component) {
        modifyComponent(component, modification: select)
    }

    mutating func rotateComponent(_ component: Component) {
        modifyComponent(component, modification: rotate)
    }

    mutating func deleteComponent(_ component: Component) {
        components.removeAll(where: { $0.id == component.id })
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

    private mutating func modifyComponent(_ component: Component, modification: (Component) -> Component) {
        guard let component = components.first(where: { $0.id == component.id }) else { return }
        guard let index = components.firstIndex(where: { $0.id == component.id }) else { return }
        components.removeAll(where: {$0.id == component.id})
        let modified = modification(component)
        components.insert(modified, at: index)
    }
}

func snapToClosest(snapX: Int, snapY: Int, point: CGPoint) -> CGPoint {
    let dX = Int(point.x) % snapX
    let dY = Int(point.y) % snapY
    let newX = Int(Int(point.x) - dX)
    let newY = Int(Int(point.y) - dY)
    return CGPoint(x: newX, y: newY)
}

func select(_ component: Component) -> Component {
    var modified = component
    modified.selected.toggle()
    return modified
}

func rotate(_ component: Component) -> Component {
    var modified = component
    modified.vertical.toggle()
    return modified
}

func move(_ point: CGPoint, _ component: Component) -> Component {
    var modified = component
    modified.move(point)
    return modified
}

extension Circuit {
    static var demo: Circuit {
        let node = Node(radius: 1, origin: .init(x: 20, y: 20))
        let wire = Wire(start: .init(x: 20, y: 20), length: 40)
        let resistor = Resistor(start: .init(x: 30, y: 20))
        let wire2 = Wire(start: .init(x: 66, y: 20), length: 40)
        return Circuit(components: [node, wire, resistor, wire2])
    }
}
