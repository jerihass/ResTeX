//
//  Created by Jericho Hasselbush on 11/10/23.
//

import SwiftUI

struct ComponentInspectorView: View {
    var component: (any Component)?

    init(component: (any Component)?) {
        self.component = component
    }

    var body: some View {
        VStack {
            makeBody()
            Spacer()
        }
        .background(.quinary)
    }

    @ViewBuilder
    func makeBody() -> some View {
        if let wire = component as? Wire {
            WireComponentInspector(model: .init(wire: wire),
                                   length: wire.length,
                                   leadingNode: wire.endPoints.leading,
                                   trailingNode: wire.endPoints.trailing)
        }
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 10)
    return ComponentInspectorView(component: wire)
}

