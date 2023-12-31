//
//  Created by Jericho Hasselbush on 10/22/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var restex: UTType {
        UTType(importedAs: "com.saletlucem.restex")
    }
}

struct ResTexDocument: FileDocument {
    var circuit: Circuit
    static var readableContentTypes: [UTType] { [.restex]}

    init(circuit: Circuit) {
        self.circuit = circuit
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let decoder = JSONDecoder()
        circuit = try decoder.decode(Circuit.self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        let data = try encoder.encode(circuit)
        return .init(regularFileWithContents: data)
    }
}
