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
    var coordinates: CGPoint { get set }
    var initialPosition: CGPoint { get set }
    var size: CGSize { get set }
    var type: ElementType { get set }
    
    func moveDown()
    func tearDown()
    
    init(initialPosition: CGPoint, size: CGSize)
}
