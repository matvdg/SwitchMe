
import Foundation
import SpriteKit

enum WallColor: Int {
    case weak = 0
    case medium
    case strong
    case unbreakable
    static var count: Int { return WallColor.unbreakable.rawValue + 1 }
    static var random: WallColor {
        return WallColor(rawValue: WallColor.count.random)!
    }
    
    func toColor() -> UIColor {
        switch self {
        case .unbreakable: return .black
        case .medium: return .blue
        case .weak: return .green
        case .strong: return .red
        }
    }
}

class Wall: Element {
    
    var initialPosition = CGPoint.zero
    var size: CGSize
    var node: SKNode
    var type: ElementType = .wall
    
    private var square: SKShapeNode {
        return self.node as! SKShapeNode
    }
    
    var color: SKColor = .red {
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
    
    required init(initialPosition: CGPoint, size: CGSize) {
        let wallCornerRadius =  Game.config["wallCornerRadius"] as! CGFloat
        
        self.node = SKShapeNode(rectOf: size, cornerRadius: wallCornerRadius)
        self.initialPosition = initialPosition
        self.size = size
        self.coordinates = initialPosition
        self.square.strokeColor = .clear
        self.square.fillColor = .red
        self.addShadow()
    }
    
    func addShadow() {
        let lightNode = SKLightNode()
        lightNode.categoryBitMask = 1
        lightNode.falloff = 0.25
        lightNode.ambientColor = .brown
        lightNode.lightColor = .purple
        lightNode.shadowColor = .yellow
        self.node.addChild(lightNode)
    }
    
    func moveDown() {
        self.coordinates.y -= GameScene.yMoveVector
    }
    
    func tearDown() {
        self.node.run(SKAction.fadeOut(withDuration: 0.1)) {
            self.node.removeFromParent()
        }
    }
    
}
