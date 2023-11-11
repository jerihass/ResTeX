//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResTexApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ResTexDocument(circuit: .demo)) { file in
            ContentView(document: file.$document)
            }
    }
}
