
import Foundation
import SpriteKit

enum PlayerColor: String {
    case red
    case green
    case blue
}

class Player: Element {
    
    var node: SKNode
    var type: ElementType = .player
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
    
    private var square: SKShapeNode {
        return self.node as! SKShapeNode
    }
    
    init() {
        self.node = SKShapeNode(rectOf: CGSize(width: cellSize, height: cellSize))
        self.square.strokeColor = .clear
        self.square.fillColor = .red
        self.square.position = self.coordinates.position
    }
    
    func switchColor() {
        switch self.color {
        case UIColor.red:
            self.color = .green
        case UIColor.green:
            self.color = .blue
        default:
            self.color = .red
        }
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
    
    func computeNextRender() {
        
    }
    
}
