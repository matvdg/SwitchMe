
import Foundation
import SpriteKit

enum PlayerColor: String {
    case red
    case green
    case blue
}

class Player: SKShapeNode, Element {
    
    override init() {
        super.init()
        self.path = CGPath(rect: CGRect(x: -cellSize/2, y: -cellSize/2, width: cellSize, height: cellSize), transform: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() -> SKNode {
        self.fillColor = self.color
        self.strokeColor = .clear
        self.position = self.coordinates.position
        return self
    }
    
    var color: SKColor = .red {
        didSet {
            self.fillColor = self.color
        }
    }
    
    var coordinates = Coordinates(x: .center, y: 100) {
        didSet {
            self.position = self.coordinates.position
        }
    }
    
    func switchColor() {
        switch self.color {
        case .red:
            self.color = .green
        case .green:
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
    
    
}
