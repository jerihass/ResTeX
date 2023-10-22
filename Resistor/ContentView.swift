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
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(ResistorDocument()))
}
