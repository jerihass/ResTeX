//
//  Created by Jericho Hasselbush on 11/4/23.
//

import XCTest
@testable import ResTeX

final class ResTexModelTests: XCTestCase {
    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 20, y: 20), length: 40)
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

    func test_shouldUpdateComponent() throws {
        let sut = ResTexModel(circuit: .init(components: [node, wire, resistor]), callback: { _ in })
        sut.selectComponent(wire)
        wire.length = 100
        sut.updateComponent(wire)
        sut.selectComponent(wire)
        let component = sut.selectedComponent as? Wire
        XCTAssertEqual(component?.length, 100)
    }

    func test_shouldUpdateComponentAndMaintainProperties() throws {
        var circuit: Circuit = .init(components: [node, wire, resistor])
        let sut = ResTexModel(circuit: circuit, callback: { circuit = $0 })
        sut.selectComponent(wire)
        let selected = sut.handleTapAtPoint(point: wire.start)
        XCTAssertEqual(selected?.id, wire.id)
        sut.moveComponent(sut.selectedComponent!, destination: .init(x: 100, y: 100))
        XCTAssertEqual(sut.selectedComponent?.origin, .init(x: 100, y: 100))
        var wireToModify = try XCTUnwrap(sut.selectedComponent as? Wire)
        wireToModify.endPoints.leading = true
        sut.updateComponent(wireToModify)
        XCTAssertEqual((sut.selectedComponent as! Wire).endPoints.leading, true)
        let cirWire = sut.circuit.components.first(where: {$0.id == wire.id})
        XCTAssertEqual(cirWire?.origin, .init(x: 100, y: 100))
    }
}
