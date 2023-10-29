//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var components: [ComponentPresenter] = [ComponentPresenter]()
    var circuit: Circuit

    init(circuit: Circuit) {
        self.circuit = circuit
        self.components = circuit.presenter
    }

    var body: some View {
        ScrollView {
            ZStack {
                ForEach(components) { item in
                    item.draw()
                }
            }
        }
    }
}

#Preview {
    return ResistorEditor(circuit: Circuit(components: [
        Node(radius: 5, origin: .init(x: 60, y: 75)),
        Wire(start: .init(x: 60, y: 75), end: .init(x: 60, y: 300)),
        Resistor(start: .init(x: 50, y: 50)),
        Resistor(start: .init(x: 100, y: 100), vertical: true)]))
}
