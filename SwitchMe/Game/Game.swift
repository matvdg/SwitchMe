import Foundation
import SpriteKit

protocol GameDelegate {
    func didUpdate(score: Int)
    func gameOver()
}

class Game {
    
    var delegate: GameDelegate?
    var scene: GameScene
    var player: Player
    var map: Map
    var isRunning = true
    
    init() {
        self.scene = GameScene()
        self.player = Player()
        self.map = Map(scene: self.scene)
    }
    
    var score = 0 {
        willSet {
            self.delegate?.didUpdate(score: newValue)
            if newValue > 10 {
                GameScene.yMoveVector = GameScene.yMoveVectorInitial + CGFloat(log10(Double(newValue)))
                print(GameScene.yMoveVector)
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
        
        return elementAY <= elementBY + Map.cellSize
            && elementAY >= elementBY - Map.cellSize
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
