//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var components: [ComponentPresenter] = [ComponentPresenter]()
    @State var circuit: Circuit

    init(circuit: Circuit) {
        self.circuit = circuit

        for item in circuit.components {
            if item is Node {
                self.components.append(.init(circuitShape: NodeShape(point: item as! Node)))
            }
            if item is Wire {
                self.components.append(.init(circuitShape: WireShape(line: item as! Wire)))
            }
            if item is Resistor {
                guard let res = item as? Resistor else { return }
                self.components.append(.init(circuitShape: ResistorShape(resistor: res, vertical: res.vertical ?? false)))
            }
        }
    }

    var body: some View {
        ZStack {
            ForEach(components) { item in
                item.draw()
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
