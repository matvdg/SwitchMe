
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
    
    var coordinates = Coordinates(x: .center, y: 100)
    
    init() {
        self.node = SKShapeNode(rectOf: CGSize(width: Map.cellSize, height: Map.cellSize), cornerRadius: Game.config["playerCornerRadius"] as! CGFloat)
        self.square.strokeColor = .clear
        self.square.fillColor = self.color
        self.square.position = self.coordinates.position
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
    
    func move(x: CGFloat) {
        self.square.position = CGPoint(x: x, y: self.coordinates.y)
    }
    
    func moveLeft() {
        let currentPosition = self.coordinates.x.rawValue
        let newPosition = currentPosition - 1 >= 0 ? currentPosition - 1 : 0
        self.coordinates.x = Alignment(rawValue: newPosition)!
    }
    
    func moveRight() {
        let currentPosition = self.coordinates.x.rawValue
        let newPosition = currentPosition + 1 < 5 ? currentPosition + 1 : 4
        self.coordinates.x = Alignment(rawValue: newPosition)!
    }
    
    func moveDown() {}

    func tearDown() {
        self.color = .green
        self.coordinates.x = .center
        self.node.removeFromParent()
    }
    
    
}
