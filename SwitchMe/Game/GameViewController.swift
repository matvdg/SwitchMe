import UIKit
import SpriteKit

class GameViewController: UIViewController, GameDelegate, UIGestureRecognizerDelegate {
    
    var game: Game!
    
    @IBOutlet weak var gameOverBlurView: UIVisualEffectView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var mapView: SKView!
    
    @IBAction func changeColor(_ sender: UITapGestureRecognizer) {
        let tapLocationX = sender.location(in: self.view).x
        if tapLocationX < self.game.map.width / 2 {
            self.game.player.switchColor(left: true)
        } else {
            self.game.player.switchColor(right: true)
        }
    }
    
    @IBAction func retry(_ sender: Any) {
        self.game.reset()
        self.gameOverBlurView.isHidden = true
    }
    
    func didUpdate(score: Int) {
        self.scoreLabel.text = String(score)
    }
    
    func gameOver() {
        self.gameOverBlurView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("UI Loaded")
        
        // Load the application configurations
        Game.loadConfig()
        
        // Game configurations must be loaded before the game is created
        self.game = Game()
        self.gameOverBlurView.isHidden = true
        self.game.delegate = self
        
        // Load the SKScene from 'GameScene.sks'
        self.game.prepare(viewSize: self.mapView.bounds.size)
        
        // Present the scene
        self.mapView.presentScene(self.game.scene)
        self.mapView.ignoresSiblingOrder = true
        self.mapView.showsFPS = false
        self.mapView.showsNodeCount = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
