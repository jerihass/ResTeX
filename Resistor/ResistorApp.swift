//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResistorApp: App {

//    @State var circuit: Circuit = Circuit(components: [Resistor(start: .init(x: 50, y: 50)),
//                                                Wire(start: .init(x: 10, y: 10), end: .init(x: 40, y: 10))])

    var body: some Scene {
        DocumentGroup(newDocument: ResistorDocument(circuit: .init())) { file in
                ContentView(document: file.$document)
            }
    }
}
