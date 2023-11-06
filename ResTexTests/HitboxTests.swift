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

    func test_shouldRotateRectNinetyDegrees() throws {
        let rect: CGRect = .init(x: 0, y: 0, width: 20, height: 30)
        let rotated = rotateRect(rect)
        XCTAssertEqual(rotated, .init(x: 0, y: 0, width: 30, height: 20))
    }

    func test_shouldHitboxRotatedResistor() throws {
        var hit: CGPoint = .init(x: 20, y: 3)
        resistor.vertical.toggle()
        let nodeshape = ResistorShape(resistor: resistor)
        var didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, false)

        hit = CGPoint(x: 3, y: 10)
        didHit = nodeshape.inBounds(point: hit)
        XCTAssertEqual(didHit, true)
    }
}
