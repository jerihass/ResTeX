//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResTexApp: App {
    var node = Node(radius: 5, origin: .init(x: 20, y: 20))
    var wire = Wire(start: .init(x: 20, y: 20), end: .init(x: 30, y: 20))
    var resistor = Resistor(start: .init(x: 30, y: 20))
    var wire2 = Wire(start: .init(x: 66, y: 20), end: .init(x: 76, y: 20))


    var body: some Scene {
        DocumentGroup(newDocument: ResTexDocument(circuit: .init(components: [node, wire, resistor, wire2]))) { file in
                ContentView(document: file.$document)
            }
    }
}
