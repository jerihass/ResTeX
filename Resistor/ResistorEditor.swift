//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

struct ResistorEditor: Sendable, View {
    var items: [CircuitComponent] = [CircuitComponent]()

    init(circuit: Circuit) {
        for item in circuit.components {
            if item is Point {
                self.items.append(.init(circuitShape: NodeShape(point: item as! Point)))
            }
            if item is Line {
                self.items.append(.init(circuitShape: ShortShape(line: item as! Line)))
            }
        }
    }

    var body: some View {
        ZStack {
            ForEach(items) { item in
                item.draw()
            }
        }
    }
}

#Preview {
    return ResistorEditor(circuit: Circuit(components: [Point(radius: 5, origin: .zero),
                                  Line(start: .init(x: 60, y: 75), end: .init(x: 175, y: 300)),
                                  Point(radius: 10, origin: .init(x: 150, y: 350))]))
}
