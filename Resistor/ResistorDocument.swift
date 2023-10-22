//
//  ResistorDocument.swift
//  Resistor
//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var restest: UTType {
        UTType(importedAs: "com.saletlucem.restest")
    }
}

struct ResistorDocument: FileDocument {
    var component: CircuitCodable
    static var readableContentTypes: [UTType] { [.restest]}

    init(component: CircuitCodable = Point(radius: 20, origin: .zero)) {
        self.component = component
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let decoder = JSONDecoder()
        component = try decoder.decode(Point.self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        let data = try encoder.encode(component)
        return .init(regularFileWithContents: data)
    }
}
