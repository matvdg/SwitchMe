import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene = GameScene()

    @IBAction func swipeRight(_ sender: Any) {
        self.scene.moveRight()
    }
    @IBAction func swipeLeft(_ sender: Any) {
        self.scene.moveLeft()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            self.scene.backgroundColor = UIColor(named: "map")!
            self.scene.scaleMode = .aspectFill
            self.scene.size = self.view.bounds.size
            // Present the scene
            view.presentScene(self.scene)
            self.scene.addPlayer()
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
