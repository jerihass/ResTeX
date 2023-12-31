//
//  Created by Jericho Hasselbush on 10/23/23.
//

import XCTest
@testable import ResTeX

final class CircuitTests: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 0, y: 0), length: 40)
    var resistor = Resistor(start: .init(x: 3, y: 3))

    var sut: Circuit!

    override func setUp() async throws {
        sut = Circuit(components: [node, wire, resistor])
    }

    func test_shouldMoveComponentOrigin() {
        sut.moveComponent(node, to: CGPoint(x: 5, y: 5))
        let moved = sut.components.first(where: {$0.id == node.id})
        XCTAssertEqual(moved?.origin, .init(x: 5, y: 5))
    }

    func test_shouldMoveWireOrigin() {
        sut.moveComponent(resistor, to: CGPoint(x: 5, y: 5))
        let moved = sut.components.first(where: {$0.id == resistor.id})
        XCTAssertEqual(moved?.origin, .init(x: 5, y: 5))
    }

    func test_circuitShouldDeleteComponent() throws {
        sut.deleteComponent(node)
        XCTAssertEqual(sut.components.count, 2)
    }

    func test_shouldRotateComponent() throws {
        sut.rotateComponent(resistor)
        let rotated = sut.components.first(where: {$0.id == resistor.id}) as? Resistor
        XCTAssertEqual(rotated?.vertical, true)
        XCTAssertEqual(sut.components.count, 3)
    }

    func test_shouldUpdateComponent() throws {
        wire.length = 200
        sut.updateComponent(wire)
        let updated = sut.components.first(where: { $0.id == wire.id }) as? Wire
        XCTAssertEqual(updated?.length, 200)
    }
}
