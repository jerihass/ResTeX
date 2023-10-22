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
        ResistorEditor(circuit: document.circuit)
    }
}

#Preview {
    ContentView(document: .constant(ResistorDocument(circuit: Circuit())))
}
