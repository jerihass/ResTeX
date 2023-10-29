//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

protocol ComponentShape {
    var shape: any CircuitShape { get }
}

extension Node: ComponentShape {
    var shape: any CircuitShape {
        NodeShape(point: self)
    }
}

extension Wire: ComponentShape {
    var shape: any CircuitShape {
        WireShape(line: self)
    }
}

extension Resistor: ComponentShape {
    var shape: any CircuitShape {
        ResistorShape(resistor: self, vertical: self.vertical ?? false)
    }
}
