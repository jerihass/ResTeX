//
//  Created by Jericho Hasselbush on 11/8/23.
//

import SwiftUI

private struct CircuitShapePreviews: View {
    fileprivate let previews: PreviewShapes = .init()
    var body: some View {
        ScrollView {
            ForEach(previews.presenter) { item in
                item.draw()
            }
        }
    }
}

#Preview {
    CircuitShapePreviews()
}

fileprivate struct PreviewShapes {
    var presenter: [ComponentPresenter] = .init()
    let origin = CGPoint(x: 20, y: 20)

    init() {
        let resistor: ResistorShape = .init(resistor: .init(start: origin))
        let wire: WireShape = .init(wire: .init(start: origin, length: 40, endPoints: .init(leading: true, trailing: true)))
        let resistor2: ResistorShape = .init(resistor: .init(start: origin, vertical: true))

        self.presenter.append(ComponentPresenter(circuitShape: resistor))
        self.presenter.append(ComponentPresenter(circuitShape: wire))
        self.presenter.append(ComponentPresenter(circuitShape: resistor2))

    }
}
