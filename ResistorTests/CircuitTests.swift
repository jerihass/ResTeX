//
//  Created by Jericho Hasselbush on 10/23/23.
//

import XCTest
@testable import Resistor

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
        let sut = ResistorModel(circuit: circuit, callback: { _ in })
        sut.selectComponent(node)
    }

    func test_shouldHitboxNode() throws {
        let hit: CGPoint = .init(x: 0, y: 0)
        let didHit = node.inBounds(point: hit)
        XCTAssertEqual(didHit, true)
    }

    func test_shouldMissHitbox() throws {
        let hit = CGPoint(x: 100, y: 100)
        let didHit = node.inBounds(point: hit)
        XCTAssertEqual(didHit, false)
    }
}
