//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ResTexDocument
    
    var body: some View {
        ResTexEditor(model: ResTexModel(circuit: document.circuit,
                                            callback: { circuit in
            document.circuit = circuit
        }))
    }
}

#Preview {
    ContentView(document: .constant(ResTexDocument(circuit: Circuit())))
}
