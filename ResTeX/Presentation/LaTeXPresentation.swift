//
//  Created by Jericho Hasselbush on 10/31/23.
//

import Foundation

protocol LaTeXRepresentable {
    var latexString: String { get }
}

extension Resistor: LaTeXRepresentable {
    var latexString: String {
        if vertical {
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=R] (\(origin.x)pt,\(origin.y / -1 - 40)pt)"

        } else {
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=R] (\(origin.x + 40)pt,\(origin.y / -1)pt)"
        }
    }
}

extension Wire: LaTeXRepresentable {
    var latexString: String {
        let sx = start.x
        let sy = start.y * -1
        let ey = vertical ? sy - length : sy
        let ex = vertical ? sx : sx + length
        return "(\(sx)pt,\(sy)pt) to [short, -] (\(ex)pt,\(ey)pt)"
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
            } else {
                fullString += ";"
            }
        }
        return fullString
    }
}
