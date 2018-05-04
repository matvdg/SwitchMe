import Foundation
import SpriteKit

enum ElementType {
    case player
    case wall
    case weaponBonus
}

protocol Element {
    
    var node: SKNode { get set }
    var color: SKColor { get set }
    var coordinates: Coordinates { get set }
    var type: ElementType { get set }
    func moveDown()
    func tearDown()
    
}
