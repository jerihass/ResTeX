//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

protocol HitBox {
    func inBounds(point: CGPoint) -> Bool
}

extension NodeShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let node = self.component as? Node else { return false }
        return node.rect.contains(point)
    }
}

extension WireShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let wire = self.component as? Wire else { return false }
        return wire.rect.contains(point)
    }
}

extension ResistorShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let resistor = self.component as? Resistor else { return false }
        return resistor.rect.contains(point)
    }
}

extension CapacitorShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let cap = self.component as? Capacitor else  { return false }
        return cap.rect.contains(point)
    }
}

func rotateRect(_ rect: CGRect) -> CGRect {
    return CGRect(origin: rect.origin, size: .init(width: rect.height, height: rect.width))
}
