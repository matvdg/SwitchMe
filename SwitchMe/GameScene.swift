import SpriteKit

class GameScene: SKScene {
    
    private var player = Player()
    private var map = Map()
    private var previousTime: TimeInterval = 0
    private let refreshRate: TimeInterval = 1/60 // 60fps like The Hobbitches
    
    static let yMoveVector: CGFloat = 5
    
    func prepare(viewSize: CGSize) {
        self.map.scene = self
        self.backgroundColor = UIColor(named: "map")!
        self.scaleMode = .aspectFill
        self.size = viewSize
        self.addPlayer()
        self.map.addLine()
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
        guard currentTime - self.previousTime >= self.refreshRate else { return }
        self.previousTime = currentTime
        self.map.render()
    }
    
}
