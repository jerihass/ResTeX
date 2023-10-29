//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

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

    func selectComponent(_ component: Component) {
        circuit.selectComponent(component)
    }
}

struct ResistorEditor: Sendable, View {
    @ObservedObject var model: ResistorModel
    @State private var selectedComponent: (any Component)?

    init(model: ResistorModel) {
        self.model = model
    }

    var body: some View {
        ZStack {
            ForEach(model.circuit.presenter) { item in
                item.draw()
                    .foregroundStyle(item.selected ? Color.red : Color.primary)
            }
        }
        .onTapGesture { point in
            for component in model.circuit.components {
                if let hitbox = component as? HitBox, hitbox.inBounds(point: point) {
                    model.selectComponent(component)
                    selectedComponent = component
                } else { }
            }
        }
        .gesture(drag)
    }

    var drag: some Gesture {
        return DragGesture()
            .onChanged { value in
                if let sel = selectedComponent {
                    model.moveComponent(sel, destination: value.location)
                }
            }
            .onEnded { value in
                if let sel = selectedComponent {
                    model.moveComponent(sel, destination: value.location)
                }
            }
    }
}

#Preview {
    return ResistorEditor(model: .init(circuit: Circuit(components: [Resistor(start: .init(x: 50, y: 50))]),
                                       callback: { _ in }))
}
