import UIKit
import SpriteKit

class Map {
    
    static let numberOfColumns = Alignment.count
    
    var elements = [Element]()
    var scene = SKScene()
    
    func render() {
        self.elements.forEach {
            $0.moveDown()
        }
    }
    
    func addElement(element: Element) {
        self.elements.append(element)
        self.scene.addChild(element.node)
    }
    
    func addLine() {
        
        ElementsGenerator().generateWallLine().forEach {
            self.addElement(element: $0)
        }
    }
    
}
