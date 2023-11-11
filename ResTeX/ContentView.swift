//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ResTexDocument
    
    var body: some View {
        HStack {
            ResTexEditor(model: ResTexModel(circuit: document.circuit,
                                            callback: { circuit in
                document.circuit = circuit
            }))
            ComponentInspectorView(component: Wire(start: .zero, length: 5))
        }
    }
}

#Preview {
    ContentView(document: .constant(ResTexDocument(circuit: Circuit())))
}
