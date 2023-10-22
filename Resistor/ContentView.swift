//
//  ContentView.swift
//  Resistor
//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: ResistorDocument

    var body: some View {
        ResistorEditor(items: [document.component])
    }
}

#Preview {
    ContentView(document: .constant(ResistorDocument(component: Line(start: .init(x: 0, y: 0), end: .init(x: 10, y: 10)))))
}
