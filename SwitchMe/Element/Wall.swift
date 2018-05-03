
import Foundation
import SpriteKit

enum WallColor: Int {
    case red = 0
    case green
    case blue
    case black
    static var count: Int { return WallColor.black.rawValue + 1 }
    static var random: WallColor {
        return WallColor(rawValue: WallColor.count.random)!
    }
    
    func toColor() -> UIColor {
        // FIXME: improve switch
        switch self {
        case .black: return .black
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
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
        self.node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.square.strokeColor = .clear
        self.square.fillColor = .red
        self.square.position = self.coordinates.position
    }
    
    func moveDown() {
        self.coordinates.y -= GameScene.yMoveVector
    }
    
}
