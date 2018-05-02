import UIKit
import SpriteKit

class Map {
    
    private var scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    var elements = [Element]()
    
    func render() {
        elements.forEach { $0.node }
    }
    
    func computeNextGeneration() {
        
    }
    
}
