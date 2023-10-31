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


