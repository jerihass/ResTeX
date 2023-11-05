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
        let size = CGSize(width: Double(node.radius), height: Double(node.radius))
        let rect = CGRect(origin: self.origin,
                          size: size)
        return rect.contains(point)
    }
}

extension WireShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let wire = self.component as?  Wire else { return false }
        let lineRect: CGRect = CGRect(x: wire.start.x,
                                      y: wire.start.y - 1.5,
                                      width: wire.end.x - wire.start.x <= 3 ? 3 : wire.end.x - wire.start.x,
                                      height: wire.end.y - wire.start.y <= 3 ? 3 : wire.end.y - wire.start.y)
        return lineRect.contains(point)
    }
}

extension ResistorShape: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        guard let wire = self.component as? Resistor else { return false }
        let resRect = CGRect(origin: .init(x: wire.start.x, y: wire.start.y - 5), size: .init(width: 36, height: 10))
        return resRect.contains(point)
    }
}
