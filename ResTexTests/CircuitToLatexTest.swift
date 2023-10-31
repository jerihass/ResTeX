//
//  Created by Jericho Hasselbush on 10/31/23.
//

import XCTest
@testable import ResTex

final class CircuitToLatexTest: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 0, y: 0), end: .init(x: 5, y: 5))
    var resistor = Resistor(start: .init(x: 3, y: 3))

    func test_shouldGenerateBasicLatexStringFromResistor() throws {
        let circuit = Circuit(components: [node, wire, resistor])
        let sut = circuit.latexString
        XCTAssertEqual(sut, "[R, l=LABEL] (5.0,3.0)")
    }
}

extension Circuit {
    var latexString: String {
        var fullString: String = ""
        for component in components {
            fullString += component.toLatexString()
        }
        return fullString
    }
}

extension Resistor: LaTeXRepresentable {
    var latexString: String {
        "[R, l=LABEL] (\(origin.x + 2),\(origin.y))"
    }
}

protocol LaTeXRepresentable {
    var latexString: String { get }
}

extension Component {
    func toLatexString() -> String {
        if let res = self as? Resistor {
            return res.latexString
        }
        return ""
    }
}
