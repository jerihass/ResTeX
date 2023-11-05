//
//  Created by Jericho Hasselbush on 11/4/23.
//

import XCTest
@testable import ResTex

final class HitboxTests: XCTestCase {

    var node = Node(radius: 5, origin: .init(x: 0, y: 0))
    var wire = Wire(start: .init(x: 0, y: 0), end: .init(x: 5, y: 5))
    var resistor = Resistor(start: .init(x: 3, y: 3))

    func test_shouldHitboxNode() throws {
        var hit: CGPoint = .init(x: 0, y: 0)
        let nodeshape = NodeShape(node: node)
        var didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, true)

        hit = CGPoint(x: 100, y: 100)
        didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, false)
    }

    func test_shouldHitboxWire() throws {
        var hit: CGPoint = .init(x: 0, y: 0)
        let nodeshape = WireShape(line: wire)
        var didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, true)

        hit = CGPoint(x: 100, y: 100)
        didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, false)
    }

    func test_shouldHitboxResistor() throws {
        var hit: CGPoint = .init(x: 3, y: 3)
        let nodeshape = ResistorShape(resistor: resistor)
        var didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, true)

        hit = CGPoint(x: 100, y: 100)
        didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, false)
    }
}
