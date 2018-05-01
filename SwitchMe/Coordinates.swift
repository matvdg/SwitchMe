import UIKit

let cellSize = UIScreen.main.bounds.width / 6

struct Coordinates {
    
    var x: Alignment
    var y: CGFloat
    
    var position: CGPoint {
        return CGPoint(x: x.rawValue * cellSize + cellSize, y: y)
    }
}

enum Alignment: CGFloat {
    case left = 0, leftCenter, center, rightCenter, right
}
