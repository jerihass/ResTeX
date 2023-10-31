//
//  Created by Jericho Hasselbush on 10/31/23.
//

import XCTest
@testable import ResTex

final class CircuitToLatexTest: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 20, y: 20))
    var wire = Wire(start: .init(x: 20, y: 20), end: .init(x: 30, y: 20))
    var resistor = Resistor(start: .init(x: 30, y: 20))
    var wire2 = Wire(start: .init(x: 66, y: 20), end: .init(x: 76, y: 20))

    func test_shouldGenerateBasicLatexStringFromResistor() throws {
        let circuit = Circuit(components: [resistor])
        let sut = circuit.latexString
        XCTAssertEqual(sut, "[R, l=LABEL] (5.0,3.0)")
    }

    func test_shouldGenerateLaTeXWithSeveralComponent() throws {
        let circuit = Circuit(components: [wire, resistor, wire2])
        let sut = circuit.latexString
        let latex = """
                    [short, -] (5.0,5.0)
                    to [R, l=LABEL] (5.0,3.0);
                    """
        print(sut)
        XCTAssertEqual(sut,latex)
    }
}

extension Circuit {
    var latexString: String {
        var fullString: String = ""
        let latex = components.compactMap({$0 as? LaTeXRepresentable})
        for component in latex.enumerated() {
            fullString += component.element.latexString
            if component.offset < latex.count - 1 {
                fullString += "\n"
            }
            if component.offset != latex.endIndex - 1 {
                fullString += "to "
            } else {
                fullString += ";"
            }
        }
        return fullString
    }
}

protocol LaTeXRepresentable {
    var latexString: String { get }
}

extension Resistor: LaTeXRepresentable {
    var latexString: String {
        // Resistor min length is 1.2, so +2
        // TODO: Handle vertical resistors?
        "(\(origin.x / 20),\(origin.y / -20)) to [R, l=LABEL] (\(origin.x / 20 + 2),\(origin.y / -20))"
    }
}

extension Wire: LaTeXRepresentable {
    var latexString: String {
        let sx = start.x / 20
        let sy = start.y / 20 * -1
        let ex = end.x / 20
        let ey = end.y / 20 * -1
        return "(\(sx),\(sy)) to [short, -] (\(ex),\(ey))"
    }
}

extension Node: LaTeXRepresentable {
    var latexString: String {
        "BAD NODE"
    }
}

