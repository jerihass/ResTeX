//
//  CircuitShapes.swift
//  Resistor
//
//  Created by Jericho Hasselbush on 10/22/23.
//

import Foundation
import SwiftUI

protocol CircuitShape: Shape, Identifiable {}

struct CircuitComponent: Identifiable {
    var id = UUID()
    var circuitShape: any CircuitShape
    var fill: Bool = false
    func draw(in rect: CGRect = .infinite) -> some View {
        return makeBody()
    }

    @ViewBuilder
    private func makeBody() -> some View {
        if fill {
            circuitShape.path(in: .infinite).fill()
        } else {
            circuitShape.path(in: .infinite).stroke(lineWidth: 2.0)
        }
    }
}

struct NodeShape: CircuitShape {
    var id = UUID()
    var point: Point
    func path(in rect: CGRect = .infinite) -> Path {
        var path = Path()

        path.addArc(center: point.origin,
                 radius: CGFloat(point.radius),
                 startAngle: .zero,
                 endAngle: .degrees(360),
                 clockwise: true)
        path.closeSubpath()

        return path
    }
}

struct ShortShape: CircuitShape {
    var id = UUID()
    var line: Line
    var thickness: Int = 1
    func path(in rect: CGRect = .infinite) -> Path {

        var path = Path()
        path.move(to: line.start)
        path.addLine(to: line.end)
        path.closeSubpath()

        return path
    }
}

struct ResistorShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        return path
    }
}
