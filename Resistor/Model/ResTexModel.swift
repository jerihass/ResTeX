//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

class ResTexModel: ObservableObject {
    @Published var circuit: Circuit
    @Published private(set) var selectedComponent: Component?
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
}
