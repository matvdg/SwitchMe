import UIKit
import SpriteKit

class Map {
    
    var elements = [Element]()
    var scene = SKScene()
    
    func render() {
        
    }
    
    func addElement(element: Element) {
        self.elements.append(element)
        self.scene.addChild(element.node)
    }
    
}
