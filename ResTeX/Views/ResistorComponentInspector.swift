//
//  Created by Jericho Hasselbush on 11/12/23.
//

import SwiftUI

class ResistorModel: ComponentModel {
    var component: Resistor
    var handler: (Resistor) -> Void
    init(resistor: Resistor, handler: @escaping (Resistor) -> Void = { _ in }) {
        self.component = resistor
        self.handler = handler
    }
    func changeLength(_ length: CGFloat) {
        component.length = length
        handler(component)
    }
    func changeLabel(_ label: String) {
        component.label = label
        handler(component)
    }
}

struct ResistorComponentInspector: View {
    @ObservedObject var model: ResistorModel
    @State var length: CGFloat
    @State var label: String
    init(model: ResistorModel) {
        self.model = model
        self.length = model.component.length
        self.label = model.component.label
    }

    var body: some View {
        VStack {
            Text("Resistor")
                .padding()
            Form {
                TextField("Length:", value: $length, formatter: NumberFormatter())
                    .padding(.horizontal)
                TextField("Label:", text: $label)
                    .padding(.horizontal)
            }
            .onChange(of: length) { model.changeLength($0) }
            .onChange(of: label) { model.changeLabel($0) }
        }
    }
}

#Preview {
    @State var resistor = Resistor(start: .zero, length: 60 , vertical: true)
    return ResistorComponentInspector(model: .init(resistor: resistor))
}

protocol ComponentModel: ObservableObject {
    associatedtype CircuitComponent = Component
    var component: CircuitComponent { get }
    var handler: (CircuitComponent) -> Void { get set }
}

struct InspectorViewFactory {
    var view: (Component) -> any View
}
