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
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=\(label)] (\(origin.x)pt,\(origin.y / -1 - self.length)pt)"

        } else {
            return "(\(origin.x)pt,\(origin.y / -1)pt) to [R, l=\(label)] (\(origin.x + self.length)pt,\(origin.y / -1)pt)"
        }
    }
}

extension Wire: LaTeXRepresentable {
    var latexString: String {
        let sx = start.x
        let sy = start.y * -1
        let ey = vertical ? sy - length : sy
        let ex = vertical ? sx : sx + length
        let leadNode = self.endPoints.leading ? "*" : ""
        let trailNode = self.endPoints.trailing ? "*" : ""
        return "(\(sx)pt,\(sy)pt) to [short, \(leadNode)-\(trailNode)] (\(ex)pt,\(ey)pt)"
    }
}

extension Node: LaTeXRepresentable {
    var latexString: String {
        let x = origin.x
        let y = origin.y * -1
        return "(\(x)pt,\(y)pt) node[circ]{} to (\(x)pt,\(y)pt)"
    }
}
extension Capacitor: LaTeXRepresentable {
    var latexString: String {
        let x = origin.x
        let y = origin.y
        return "(\(x)pt,\(y / -1)pt) to [C, l=\(label)] (\(x + self.length)pt,\(y / -1)pt)"
    }
}
extension Circuit {
    var latexString: String {
        var fullString: String = ""

        fullString += LaTeXStrings.begin
        fullString += LaTeXStrings.draw

        let latexComponents = components.compactMap({$0 as? LaTeXRepresentable})
        for component in latexComponents.enumerated() {
            fullString += component.element.latexString
            if component.offset < latexComponents.count - 1 {
                fullString += "\n"
            } else {
                fullString += ";\n"
            }
        }

        fullString += LaTeXStrings.end

        return fullString
    }
}

struct LaTeXStrings {
    static var begin: String = "\\begin{circuitikz}[american voltages]\n"
    static var draw: String = "\\draw\n"
    static var end: String = "\\end{circuitikz}\n"
}
