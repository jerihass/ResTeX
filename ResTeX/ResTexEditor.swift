//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

struct ResTexEditor: Sendable, View {
    @ObservedObject var model: ResTexModel
    @State private var selectedComponent: (any Component)?

    init(model: ResTexModel) {
        self.model = model
    }

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Button("Resistor", action: {
                        model.addComponent(Resistor(start: .init(x: 20, y: 20)))
                    })
                    Button("Node", action: {
                        model.addComponent(Node(radius: 2, origin: .init(x: 30, y: 30)))
                    })
                    Button("Wire", action: {
                        model.addComponent(Wire(start: .init(x: 40, y: 40), length: 40))
                    })
                    Button("Make Latex", action: { model.makeLatex() })
                    Button("Delete", action: { model.deleteComponent(selectedComponent)})
                    Button("Rotate", action: { model.rotateComponent(selectedComponent) })
                }
                ZStack {
                    Rectangle().fill().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).foregroundStyle(.ultraThinMaterial).backgroundStyle(.clear)
                    ForEach(model.circuit.presenter) { item in
                        item.draw()
                            .foregroundStyle(item.selected ? Color.red : Color.primary)
                    }
                }
                .allowsHitTesting(true)
                .onTapGesture { selectedComponent = model.handleTapAtPoint(point: $0) }
                .gesture(drag)
            }
            TextEditor(text: $model.latex)
                .frame(maxHeight: .infinity)
                .multilineTextAlignment(.leading)
                .lineLimit(10, reservesSpace: true)
        }
    }

    var drag: some Gesture {
        return DragGesture(minimumDistance: 0.0)
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
    return ResTexEditor(model: .init(circuit: Circuit(components: [Resistor(start: .init(x: 50, y: 50))]),
                                       callback: { _ in }))
}