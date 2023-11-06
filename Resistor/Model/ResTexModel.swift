//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

class ResTexModel: ObservableObject {
    @Published var circuit: Circuit
    @Published private(set) var selectedComponent: Component?
    @Published var latex: String = ""
    var callback: (Circuit) -> Void
    init(circuit: Circuit, callback: @escaping (Circuit) -> Void) {
        self.circuit = circuit
        self.callback = callback
    }

    func moveComponent(_ comp: Component, destination: CGPoint) {
        circuit.moveComponent(comp, to: destination)
        callback(circuit)
    }

    func selectComponent(_ component: Component?) {
        circuit.deselectAll()
        guard let comp = component else {
            self.objectWillChange.send()
            return
        }
        circuit.selectComponent(comp)
        self.selectedComponent = comp
    }

    func addComponent(_ component: Component) {
        circuit.components.append(component)
        callback(circuit)
    }

    func deleteComponent(_ component: Component?) {
        guard let component = component else { return }
        guard let toRemove = circuit.components.first(where: {$0.id == component.id}) else { return }
        circuit.deleteComponent(toRemove)
        callback(circuit)
    }

    func rotateComponent(_ component: Component?) {
        guard let component = component else { return }
        circuit.rotate(component)
        callback(circuit)
    }

    func makeLatex() {
        latex = circuit.latexString
        print(latex)
    }

    func handleTapAtPoint(point: CGPoint) -> Component? {
        for shape in circuit.shapes {
            if let hitbox = shape.shape as? HitBox {
                if hitbox.inBounds(point: point) {
                    selectComponent(shape.shape.component)
                    selectedComponent = shape.shape.component
                    break
                } else {
                    selectComponent(nil)
                    selectedComponent = nil
                }
            }
        }
        return selectedComponent
    }
}
