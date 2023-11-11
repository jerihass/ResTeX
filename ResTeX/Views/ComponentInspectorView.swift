//
//  Created by Jericho Hasselbush on 11/10/23.
//

import SwiftUI

struct ComponentInspectorView: View {
    var component: (any Component)?
    var handler: (any Component) -> Void

    init(component: (any Component)?, handler: @escaping (any Component) -> Void = { _ in }) {
        self.component = component
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
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 10)
    return ComponentInspectorView(component: wire)
}

