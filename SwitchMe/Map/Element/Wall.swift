
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
    
    var coordinates = Coordinates(x: .center, y: 100) {
        didSet {
            self.square.position = self.coordinates.position
        }
    }
    
    init() {
        self.node = SKShapeNode(rectOf: CGSize(width: Map.cellSize, height: Map.cellSize))
        self.square.strokeColor = .clear
        self.square.fillColor = .red
        self.addShadow()
        self.square.position = self.coordinates.position
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
