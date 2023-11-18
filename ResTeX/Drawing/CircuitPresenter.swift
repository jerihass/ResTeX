//
//  Created by Jericho Hasselbush on 11/11/23.
//

import SwiftUI

struct CircuitPresenter {
    var circuit: Circuit

    init(circuit: Circuit) {
        self.circuit = circuit
    }

    var body: some View {
        ZStack {
            flattenComponentPaths()
            selectedComponents().foregroundStyle(.red)
        }
    }

    private func flattenComponentPaths() -> some Shape {
        var path: Path = .init()
        for presenter in circuit.presenter {
            if !presenter.selected {
                print("drawing presenter: \(presenter.circuitShape)")
                path.addPath(presenter.circuitShape.path(in: .infinite))
            }
        }
        let shape = path.stroke()
        return shape
    }
    private func selectedComponents() -> some Shape {
        var path: Path = .init()
        for presenter in circuit.presenter {
            if presenter.selected {
                path.addPath(presenter.circuitShape.path(in: .infinite))
            }
        }
        let shape = path.stroke()
        return shape
    }
}

#Preview {
    let circuit = Circuit.demo
    return CircuitPresenter(circuit: circuit).body
}
