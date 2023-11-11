//
//  Created by Jericho Hasselbush on 11/11/23.
//

import SwiftUI

class WireModel: ObservableObject {
    var wire: Wire
    init(wire: Wire) {
        self.wire = wire
    }
}

struct WireComponentInspector: View {
    @ObservedObject var model: WireModel
    @State var length: CGFloat
    @State var leadingNode: Bool
    @State var trailingNode: Bool
    var body: some View {
        VStack {
            Text("Wire")
                .padding()
            Form {
                HStack {
                    TextField("Points:", value: $length, formatter: NumberFormatter())
                        .padding(.horizontal)
                }
                Toggle(isOn: $leadingNode, label: {
                    Text("Leading Node")
                })
                Toggle(isOn: $trailingNode, label: {
                    Text("Trailing Node")
                })
            }
            .frame(maxWidth: 200, alignment: .leading)
            .onChange(of: length, perform: { model.wire.length = $0 })
        }
    }
}

#Preview {
    @State var wire = Wire(start: .zero, length: 30)
    return WireComponentInspector(model: .init(wire: wire),
                                  length: wire.length,
                                  leadingNode: wire.endPoints.leading,
                                  trailingNode: wire.endPoints.trailing)
}
