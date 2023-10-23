//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResistorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ResistorDocument(circuit: Circuit(components: [
            Node(radius: 5, origin: .init(x: 60, y: 75)),
            Wire(start: .init(x: 60, y: 75), end: .init(x: 60, y: 300)),
            Resistor(start: .init(x: 50, y: 50)),
            Resistor(start: .init(x: 100, y: 100), vertical: true)]))) { file in
                ContentView(document: file.$document)
            }
    }
}
