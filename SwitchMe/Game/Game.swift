import Foundation
import SpriteKit

protocol GameDelegate {
    func didUpdate(score: Int)
    func gameOver()
}

class Game {
    
    /*
     * Static attributes and methods
     */
    static var config = NSDictionary()
    
    static func loadConfig() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            Game.config = NSDictionary(contentsOfFile: path)!
        }
    }
    
    /*
     * Instance attributes and methods
     */
    var delegate: GameDelegate?
    var scene: GameScene
    var player: Player
    var map: Map
    var isRunning = true
    
    init() {
        self.scene = GameScene()
        self.map = Map(scene: self.scene)
        
        let playerSizeRatio = Game.config["playerSizeRatio"] as! CGFloat
        let playerInitialY = Game.config["playerInitialY"] as! CGFloat
        let playerSize = CGSize(width: self.map.cellSize * playerSizeRatio, height: self.map.cellSize * playerSizeRatio)
        
        self.player = Player(initialPosition: CGPoint(x: self.map.centerX, y: playerInitialY), size: playerSize)
    }
    
    var score = 0 {
        willSet {
            self.delegate?.didUpdate(score: newValue)
            if newValue > 10 {
                GameScene.yMoveVector = GameScene.yMoveVectorInitial + CGFloat(log10(Double(newValue)))
            }
        }
    }
    
    func prepare(viewSize: CGSize) {
        self.scene.prepare(viewSize, game: self)
        self.map.set(player: self.player)
    }
    
    func scanForCollisions() {
        guard self.isRunning else { return }
        self.map.elements = self.map.elements.filter { (element) -> Bool in
            guard self.isRunning, element.type != .player else { return true }
            
            if self.isCollidedWith(elementA: element, elementB: self.player) {
                let elementColor = element.color
                let playerColor = self.player.color
                
                if elementColor == playerColor { // Player earns a point!
                    element.tearDown()
                    self.score += 1
                    Feedback.collide()
                    
                    return false
                } else { // Player dies!
                    Feedback.die()
                    self.delegate?.gameOver()
                    self.player.tearDown()
                    self.map.removePlayer()
                    self.isRunning = false
                    
                    return true
                }
            }
            
            return true
        }
    }
    
    func isCollidedWith(elementA: Element, elementB: Element) -> Bool {
        let elementAX = elementA.coordinates.x
        let elementAY = elementA.coordinates.y
        let elementBX = elementB.coordinates.x
        let elementBY = elementB.coordinates.y
        
        return elementAY <= elementBY + self.map.cellSize
            && elementAY >= elementBY - self.map.cellSize
            && elementAX == elementBX
    }
    
    func reset() {
        self.score = 0
        self.isRunning = true
        GameScene.yMoveVector = GameScene.yMoveVectorInitial
        self.map.reset()
        self.scene.reset()
        self.map.set(player: self.player)
    }
    
}
