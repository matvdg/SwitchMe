import SpriteKit

class GameScene: SKScene {
    
    private var player = Player()
    private var map = Map()
    
    func prepare(viewSize: CGSize) {
        self.map.scene = self
        self.backgroundColor = UIColor(named: "map")!
        self.scaleMode = .aspectFill
        self.size = viewSize
        self.addPlayer()
    }
    
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
        self.map.addElement(element: self.player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.map.render()
    }
    
}
