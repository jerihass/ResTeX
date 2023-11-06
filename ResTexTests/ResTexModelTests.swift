//
//  Created by Jericho Hasselbush on 11/4/23.
//

import XCTest
@testable import ResTex

final class ResTexModelTests: XCTestCase {
    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 0, y: 0), length: 40)
    var resistor = Resistor(start: .init(x: 10, y: 10))
    func test_shouldSelectComponent() throws {
        let circuit = Circuit(components: [node, wire, resistor])
        let sut = ResTexModel(circuit: circuit, callback: { _ in })
        sut.selectComponent(node)
        XCTAssertEqual(sut.selectedComponent?.id, node.id)
    }

    func test_shouldAddComponent() throws {
        let res2 = Resistor(start: .init(x: 10, y: 10))
        let sut = ResTexModel(circuit: .init(), callback: { _ in })
        sut.addComponent(res2)
        XCTAssertEqual(sut.circuit.components.count, 1)
    }

    func test_shouldSelectResistor() throws {
        let sut = ResTexModel(circuit: .init(components: [wire, resistor]), callback: { _ in })
        let comp = sut.handleTapAtPoint(point: resistor.start)
        XCTAssertEqual(comp?.id, resistor.id)
    }

    func test_shouldDeleteComponent() throws {
        let sut = ResTexModel(circuit: .init(components: [node, wire, resistor]), callback: { _ in })
        let component = sut.handleTapAtPoint(point: resistor.start)
        sut.deleteComponent(component!)
        XCTAssertEqual(sut.circuit.components.count, 2)
    }
}
