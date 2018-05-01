import Foundation
import SpriteKit

protocol Element {
    
    var color: SKColor { get set }
    var coordinates: Coordinates { get set }
    
    func render() -> SKNode
}
