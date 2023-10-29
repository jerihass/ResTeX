//
//  Created by Jericho Hasselbush on 10/29/23.
//

import Foundation

protocol HitBox {
    func inBounds(point: CGPoint) -> Bool
}

extension Node: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        let size = CGSize(width: Double(self.radius), height: Double(self.radius))
        let rect = CGRect(origin: self.origin,
                          size: size)
        return point.x <= rect.maxX && point.x >= rect.minX && point.y <= rect.maxY && point.y >= rect.minY
    }
}

extension Wire: HitBox {
    func inBounds(point: CGPoint) -> Bool {
        let lineRect: CGRect = CGRect(x: self.start.x,
                                      y: self.start.y - 1.5,
                                      width: self.end.x - self.start.x <= 3 ? 3 : self.end.x - self.start.x,
                                      height: self.end.y - self.start.y <= 3 ? 3 : self.end.y - self.start.y)
        // TODO: Need to determine if on line, not in bounding box
        return point.x <= lineRect.maxX && point.x >= lineRect.minX && point.y <= lineRect.maxY && point.y >= lineRect.minY
    }
}

extension Resistor : HitBox {
    func inBounds(point: CGPoint) -> Bool {
        let resRect = CGRect(origin: .init(x: start.x, y: start.y - 5), size: .init(width: 36, height: 10))
        return point.x <= resRect.maxX && point.x >= resRect.minX && point.y <= resRect.maxY && point.y >= resRect.minY
    }
}
