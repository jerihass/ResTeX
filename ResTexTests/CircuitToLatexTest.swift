//
//  Created by Jericho Hasselbush on 10/31/23.
//

import XCTest
@testable import ResTeX

final class CircuitToLatexTest: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 20, y: 20))
    var wire = Wire(start: .init(x: 20, y: 20), length: 40)
    var resistor = Resistor(start: .init(x: 30, y: 20))
    var wire2 = Wire(start: .init(x: 66, y: 20), length: 40)

    func test_shouldMakeLaTeXFromWire() throws {
        let sut = wire
        XCTAssertEqual(sut.latexString, "(20.0pt,-20.0pt) to [short, -] (60.0pt,-20.0pt)")
    }

    func test_shouldGenerateBasicLatexStringFromResistor() throws {
        let sut = resistor
        XCTAssertEqual(sut.latexString, "(30.0pt,-20.0pt) to [R, l=R] (70.0pt,-20.0pt)")
    }

    func test_shouldGenerateLaTeXWithSeveralComponent() throws {
        let sut = Circuit(components: [wire, resistor, wire2])
        let string = sut.latexString
        let latex = """
                    \\begin{circuitikz}[american voltages]
                    \\draw
                    (20.0pt,-20.0pt) to [short, -] (60.0pt,-20.0pt)
                    (30.0pt,-20.0pt) to [R, l=R] (70.0pt,-20.0pt)
                    (66.0pt,-20.0pt) to [short, -] (106.0pt,-20.0pt);
                    \\end{circuitikz}\n
                    """
        print(string)
        XCTAssertEqual(string,latex)
    }
}


