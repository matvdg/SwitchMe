import Foundation
import SpriteKit

enum ElementType {
    case player
    case redWall
    case blueWall
    case greenWall
    case blackWall
    case weaponBonus
}

protocol Element {
    
    var node: SKNode { get set }
    var color: SKColor { get set }
    var coordinates: Coordinates { get set }
    var type: ElementType { get set }
    
    func computeNextRender()
    
}
