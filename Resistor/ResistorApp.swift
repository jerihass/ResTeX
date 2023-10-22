//
//  ResistorApp.swift
//  Resistor
//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

@main
struct ResistorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: ResistorDocument(circuit: Circuit(components: [Point(radius: 5, origin: .zero),
                                                                                  Line(start: .init(x: 60, y: 75), end: .init(x: 175, y: 300)),
                                                                                  Point(radius: 10, origin: .init(x: 150, y: 350))]))) { file in
            ContentView(document: file.$document)
        }
    }
}
