//
//  CodableTests.swift
//  ResTexTests
//
//  Created by Jericho Hasselbush on 11/4/23.
//

import XCTest
@testable import ResTex

final class CodableTests: XCTestCase {
    func test_shouldEncodeAndDecodeCircuit() throws {
        let sut = Circuit.demo
        let encoder = JSONEncoder()
        let data = try encoder.encode(sut)
        let decoder = JSONDecoder()
        let circuit = try decoder.decode(Circuit.self, from: data)
        XCTAssertEqual(circuit.components.count, sut.components.count)
    }
}
