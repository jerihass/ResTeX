//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResTexApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ResistorDocument(circuit: .init())) { file in
                ContentView(document: file.$document)
            }
    }
}
