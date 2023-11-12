//
//  Created by Jericho Hasselbush on 11/11/23.
//

import SwiftUI

class WireModel: ObservableObject {
    var wire: Wire
    var handler: (Wire) -> Void
    init(wire: Wire, handler: @escaping (Wire) -> Void = { _ in }) {
        self.wire = wire
        self.handler = handler
    }
    func changeLength(_ length: CGFloat) {
        wire.length = length
        handler(wire)
    }
    func changeLeadingNode(_ node: Bool) {
        wire.endPoints.leading = node
        handler(wire)
    }
    func changeTrailingNode(_ node: Bool) {
        wire.endPoints.trailing = node
        handler(wire)
    }
}

struct WireComponentInspector: View {
    @ObservedObject var model: WireModel
    @State var length: CGFloat
    @State var leadingNode: Bool
    @State var trailingNode: Bool

    init(model: WireModel) {
        self.model = model
        self.length = model.wire.length
        self.leadingNode = model.wire.endPoints.leading
        self.trailingNode = model.wire.endPoints.trailing
    }

    var body: some View {
        VStack {
            Text("Wire")
                .padding()
            Form {
                HStack {
                    TextField("Length:", value: $length, formatter: NumberFormatter())
                        .padding(.horizontal)
                }
                Toggle(isOn: $leadingNode, label: {
                    Text("Leading Node")
                })
                Toggle(isOn: $trailingNode, label: {
                    Text("Trailing Node")
                })
            }
            .onChange(of: length) { model.changeLength($0) }
            .onChange(of: leadingNode) {
                model.changeLeadingNode($0)
            }
            .onChange(of: trailingNode) {
                model.changeTrailingNode($0)
            }
        }
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 30)
    return WireComponentInspector(model: .init(wire: wire))
}
