
import Foundation
import SpriteKit

class Player: Element {
    
    let animationDuration: TimeInterval = 0.05
    
    var node: SKNode
    var type: ElementType = .player
    
    private var square: SKShapeNode {
        return self.node as! SKShapeNode
    }
        
    var color: SKColor = .green {
        willSet {
            self.square.fillColor = newValue
        }
    }
    
    var coordinates: CGPoint {
        get {
            return self.node.position
        }
        set {
            self.node.position = newValue
        }
    }
    
    var size: CGSize = CGSize.zero
    var initialPosition: CGPoint = CGPoint.zero
    
    required init(initialPosition: CGPoint, size: CGSize) {
        self.node = SKShapeNode(rectOf: size, cornerRadius: Game.config["playerCornerRadius"] as! CGFloat)
        self.square.strokeColor = .clear
        self.square.fillColor = self.color
        self.coordinates = initialPosition
        self.size = size
        self.initialPosition = initialPosition
    }
    
    func switchColor(left: Bool = false, right: Bool = false) {
        switch self.color {
        case .red:
            self.color = left ? .blue : .green
        case .green:
            self.color = left ? .red : .blue
        default:
            self.color = left ? .green : .red
        }
    }
    
    func moveBy(x: CGFloat) {
        self.coordinates.x += x
    }
    
    func moveDown() {}

    func tearDown() {
        self.color = .green
        self.coordinates = self.initialPosition
        self.node.removeFromParent()
    }
    
}
