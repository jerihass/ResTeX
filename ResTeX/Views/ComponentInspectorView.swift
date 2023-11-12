//
//  Created by Jericho Hasselbush on 11/10/23.
//

import SwiftUI

struct ComponentInspectorView: View {
    @Binding var component: (any Component)?
    var handler: (any Component) -> Void

    init(component: Binding<(any Component)?>, handler: @escaping (any Component) -> Void = { _ in }) {
        self._component = component
        self.handler = handler
    }

    var body: some View {
        VStack {
            makeBody()
            Spacer()
        }
        .frame(maxWidth: 200, alignment: .leading)
        .background(.quinary)
    }

    @ViewBuilder
    func makeBody() -> some View {
        if let wire = component as? Wire {
            let wireModel = WireModel(wire: wire, handler: { handler($0) })
            WireComponentInspector(model: wireModel)
        }
        if let res = component as? Resistor {
            let resModel = ResistorModel(resistor: res, handler: { handler($0)})
            ResistorComponentInspector(model: resModel)
        }
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 10) as Component?
    @State var resistor = Resistor(start: .zero, length: 55) as Component?
    return HStack {
        ComponentInspectorView(component: $wire)
        ComponentInspectorView(component: $resistor)
    }
}

