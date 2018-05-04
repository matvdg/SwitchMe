import UIKit

struct Coordinates {
    
    var x: Alignment
    var y: CGFloat
    
    var position: CGPoint {
        return CGPoint(x: x.rawValue * Map.cellSize + Map.cellSize, y: y)
    }
}

enum Alignment: CGFloat {
    case left = 0, leftCenter, center, rightCenter, right
    static var count: Int { return Int(Alignment.right.rawValue) + 1 }
}
