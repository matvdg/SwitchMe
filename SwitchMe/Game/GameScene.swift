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
    
}
