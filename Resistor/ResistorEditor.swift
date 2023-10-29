//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    @ObservedObject var model: ResistorModel
    
    init(model: ResistorModel) {
        self.model = model
    }

    var body: some View {
        ScrollView {
            ZStack {
                ForEach(model.circuit.presenter) { item in
                    item.draw()
                }
            }
        }
        .onTapGesture {
            guard let comp = model.circuit.components.first else { return }
            let x = comp.origin.x
            model.moveComponent(comp, destination: .init(x: x + 3, y: comp.origin.y))
        }
    }
}

#Preview {
    return ResistorEditor(model: .init(circuit: Circuit(components: [Resistor(start: .init(x: 50, y: 50))]),
                                       callback: { _ in }))
}

class ResistorModel: ObservableObject {
    @Published var circuit: Circuit
    var callback: (Circuit) -> Void
    init(circuit: Circuit, callback: @escaping (Circuit) -> Void) {
        self.circuit = circuit
        self.callback = callback
    }

    func moveComponent(_ comp: Component, destination: CGPoint) {
        circuit.moveComponent(comp, to: destination)
        callback(circuit)
    }
}
