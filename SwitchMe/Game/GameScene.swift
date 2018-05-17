import SpriteKit

class GameScene: SKScene {
    
    private var previousTime: TimeInterval = 0
    private let refreshRate: TimeInterval = 0.015 //
    private var game: Game!
    
    static let yMoveVectorInitial: CGFloat = 4 // FIXME: move to Config.plist
    static var yMoveVector: CGFloat = yMoveVectorInitial
    
    func prepare(_ viewSize: CGSize, game: Game) {
        self.game = game
        self.backgroundColor = UIColor(named: "map")!
        self.scaleMode = .aspectFill
        self.size = viewSize
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard currentTime - self.previousTime >= self.refreshRate else { return }
        self.previousTime = currentTime
        self.game.scanForCollisions()
        self.game.map.render()
    }
    
    func reset() {
        GameScene.yMoveVector = GameScene.yMoveVectorInitial
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let positionInScene = touch.location(in: self)
        let previousPosition = touch.previousLocation(in: self)
        let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
        
        // TODO: move away in the right place
        let playerX = self.game.player.coordinates.x
        let playerSize = self.game.player.size
        
        guard (playerX + translation.x > playerSize.width / 2) && (playerX + translation.x < self.game.map.width -  playerSize.width / 2) else { return }
        
        self.game.player.moveBy(x: translation.x)
    }
    
}
