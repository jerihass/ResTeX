//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResistorApp: App {

    var circuit: Circuit = Circuit(components: [Resistor(start: .init(x: 50, y: 50))])

    var body: some Scene {
        DocumentGroup(newDocument: ResistorDocument(circuit: circuit)) { file in
                ContentView(document: file.$document)
            }
    }
}
