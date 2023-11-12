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
                VStack {
                    QuickButtonView(model: model, selectedComponent: $selectedComponent)
                    ZStack {
                        BackgroundView()
                        CircuitPresenter(circuit: model.circuit).body
                    }
                    .allowsHitTesting(true)
                    .onTapGesture {
                        _ = model.handleTapAtPoint(point: $0)
                        selectedComponent = model.selectedComponent
                    }
                    .gesture(drag)
                }
                TextEditor(text: $model.latex)
                    .frame(maxHeight: .infinity)
                    .multilineTextAlignment(.leading)
                    .lineLimit(10, reservesSpace: true)
            }
            ComponentInspectorView(component: $selectedComponent, handler: { comp in
                model.updateComponent(comp)
                selectedComponent = model.selectedComponent
            })
        }
    }

    var drag: some Gesture {
        return DragGesture(minimumDistance: 1)
            .onChanged { value in
                if let sel = selectedComponent {
                    model.moveComponent(sel, destination: value.location)
                }
            }
            .onEnded { value in
                if let sel = selectedComponent {
                    model.moveComponent(sel, destination: value.location)
                    selectedComponent = model.selectedComponent
                }
            }
    }

    @ViewBuilder
    func BackgroundView() -> some View {
        Rectangle()
            .fill()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .foregroundStyle(.thinMaterial)
            .backgroundStyle(.clear)
    }
}

#Preview {
    return ResTexEditor(model: .init(circuit: Circuit(components: [Resistor(start: .init(x: 50, y: 50))]),
                                       callback: { _ in }))
}

struct QuickButtonView: View {
    @ObservedObject var model: ResTexModel
    @Binding var selectedComponent: (any Component)?

    var body: some View {
        HStack {
            Button("Resistor") { model.addComponent(Resistor(start: .init(x: 20, y: 20))) }
            Button("Node") { model.addComponent(Node(radius: 3, origin: .init(x: 30, y: 30))) }
            Button("Wire") { model.addComponent(Wire(start: .init(x: 30, y: 30), length: 20)) }
            Button("Make Latex") { model.makeLatex() }
            Button("Delete") { model.deleteComponent(selectedComponent)}
            Button("Rotate") { model.rotateComponent(selectedComponent) }
        }
    }
}
