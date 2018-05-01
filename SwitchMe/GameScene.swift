import SpriteKit

class GameScene: SKScene {
    
    private var player = Player()
    
    func moveLeft() {
        self.player.moveLeft()
    }
    
    func moveRight() {
        self.player.moveRight()
    }
    
    func addPlayer() {
        self.scene?.addChild(self.player.render())
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.player.switchColor()
    }
}
