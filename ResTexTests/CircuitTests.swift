//
//  Created by Jericho Hasselbush on 10/23/23.
//

import XCTest
@testable import ResTex

final class CircuitTests: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 0, y: 0), end: .init(x: 5, y: 5))
    var resistor = Resistor(start: .init(x: 3, y: 3))

    func test_shouldMoveComponentOrigin() {
        var sut = Circuit(components: [node, wire, resistor])
        sut.moveComponent(node, to: CGPoint(x: 5, y: 5))
        let moved = sut.components.first(where: {$0.id == node.id})
        XCTAssertEqual(moved?.origin, .init(x: 5, y: 5))
    }

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

}
