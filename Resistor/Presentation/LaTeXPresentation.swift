//
//  Created by Jericho Hasselbush on 10/31/23.
//

import Foundation


protocol LaTeXRepresentable {
    var latexString: String { get }
}

extension Resistor: LaTeXRepresentable {
    var latexString: String {
        // Resistor min length is 1.2, so +2
        // TODO: Handle vertical resistors?
        "(\(origin.x / 20),\(origin.y / -20)) to [R, l=LABEL] (\(origin.x / 20 + 2),\(origin.y / -20))"
    }
}

extension Wire: LaTeXRepresentable {
    var latexString: String {
        let sx = start.x / 20
        let sy = start.y / 20 * -1
        let ex = end.x / 20
        let ey = end.y / 20 * -1
        return "(\(sx),\(sy)) to [short, -] (\(ex),\(ey))"
    }
}

extension Node: LaTeXRepresentable {
    var latexString: String {
        "BAD NODE"
    }
}