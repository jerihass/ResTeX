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
        if vertical {
//            return "(\(origin.x / 20),\(origin.y / -20)) to [R, l=LABEL] (\(origin.x / 20),\(origin.y / -20 - 2))"
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=LABEL] (\(origin.x)pt,\(origin.y / -1 - 36)pt)"

        } else {
//            return "(\(origin.x / 20),\(origin.y / -20)) to [R, l=LABEL] (\(origin.x / 20 + 2),\(origin.y / -20))"
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=LABEL] (\(origin.x + 36)pt,\(origin.y / -1)pt)"
        }
    }
}

extension Wire: LaTeXRepresentable {
    var latexString: String {
        let sx = start.x / 20
        let sy = start.y / 20 * -1
        let ey = vertical ? sy - length / 20 : sy
        let ex = vertical ? sx : sx + length / 20
        return "(\(sx),\(sy)) to [short, -] (\(ex),\(ey))"
    }
}

extension Node: LaTeXRepresentable {
    var latexString: String {
        "BAD NODE"
    }
}

extension Circuit {
    var latexString: String {
        var fullString: String = ""
        let latex = components.compactMap({$0 as? LaTeXRepresentable})
        for component in latex.enumerated() {
            fullString += component.element.latexString
            if component.offset < latex.count - 1 {
                fullString += "\n"
            }
            if component.offset != latex.endIndex - 1 {
                fullString += "to "
            } else {
                fullString += ";"
            }
        }
        return fullString
    }
}
