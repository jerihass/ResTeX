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
        let wire: WireShape = .init(wire: .init(start: origin, length: 40, endPoints: .init(leading: false, trailing: true)))
        self.presenter.append(ComponentPresenter(circuitShape: wire))

        let resistor: ResistorShape = .init(resistor: .init(start: origin, length: 80))
        self.presenter.append(ComponentPresenter(circuitShape: resistor))

//        let resistor2: ResistorShape = .init(resistor: .init(start: origin, vertical: true))
//        self.presenter.append(ComponentPresenter(circuitShape: resistor2))

        let capacitor: CapacitorShape = .init(capacitor: .init(start: origin, length: 40))
        self.presenter.append(ComponentPresenter(circuitShape: capacitor))

        let capacitor2: CapacitorShape = .init(capacitor: .init(start: origin, length: 40, vertical: true))
        self.presenter.append(ComponentPresenter(circuitShape: capacitor2))
    }
}
