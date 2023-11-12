//
//  Created by Jericho Hasselbush on 11/12/23.
//

import XCTest
@testable import ResTeX

final class ComponentInspectorTests: XCTestCase {

    func test_shouldModifyWire() throws {
        var wire = Wire(start: .zero, length: 20)
        let sut = WireModel(wire: wire, handler: {
            wire = $0
        })
        sut.changeLength(50)
        sut.changeLeadingNode(true)
        sut.changeTrailingNode(true)
        XCTAssertEqual(wire.length, 50)
        XCTAssertEqual(wire.endPoints.leading, true)
        XCTAssertEqual(wire.endPoints.trailing, true)
    }

    func test_shouldModifyResistor() throws {
        var res = Resistor(start: .zero, length: 45)
        let sut = ResistorModel(resistor: res, handler: { res = $0 })
        sut.changeLength(100)
        sut.changeLabel("R_2")
        XCTAssertEqual(res.length, 100)
        XCTAssertEqual(res.label, "R_2")
    }
}
