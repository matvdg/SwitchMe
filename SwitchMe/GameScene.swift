import SpriteKit

class GameScene: SKScene {
    
    private var player = Player()
    private var map = Map()
    
    func moveLeft() {
        self.player.moveLeft()
    }
    
    func moveRight() {
        self.player.moveRight()
    }
    
    func changeColor() {
        self.player.switchColor()
    }
    
    func addPlayer() {
        self.map.elements.append(self.player)
        self.scene?.addChild(self.player.node)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.map.render()
    }
}
