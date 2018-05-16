import UIKit
import SpriteKit

class GameViewController: UIViewController, GameDelegate, UIGestureRecognizerDelegate {
    
    var game: Game!
    
    @IBOutlet weak var gameOverBlurView: UIVisualEffectView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func didPan(recognizer: UIPanGestureRecognizer) {
        print("Pan triggered")
        //self.game.player.move(x: sender.translation(in: self.view).x)
    }
    
    @IBAction func changeColor(_ sender: UITapGestureRecognizer) {
        let tapLocationX = sender.location(in: self.view).x
        if tapLocationX < Map.width / 2 {
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
        
        let view = self.view as! SKView
        
        // Load the SKScene from 'GameScene.sks'
        self.game.prepare(viewSize: self.view.bounds.size)
        
        // Present the scene
        view.presentScene(self.game.scene)
        view.ignoresSiblingOrder = true
        view.showsFPS = false
        view.showsNodeCount = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK:- UIGestureRecognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
