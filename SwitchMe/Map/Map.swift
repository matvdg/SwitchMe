import UIKit
import SpriteKit

class Map {
    
    static let numberOfColumns = Game.config["numberOfMapColumns"] as! CGFloat
    static let numberOfCellsBetweenLines =  Game.config["numberOfCellsBetweenLines"] as! CGFloat
    
    var elements = [Element]()
    var scene: SKScene
    var player: Player!
    
    var width: CGFloat {
        return self.scene.frame.width
    }
    
    var height: CGFloat {
        return self.scene.frame.height
    }
    
    var centerX: CGFloat {
        return self.width / 2
    }
    
    var cellSize: CGFloat {
        // +1 for half a column each side as margin
        return width / Map.numberOfColumns
    }
    
    var elementsGenerator: ElementsGenerator!
    
    init(scene: SKScene) {
        self.scene = scene
        self.elementsGenerator = ElementsGenerator(map: self)
    }
    
    func render() {
        // FIXME: all following actions are done by the player element too
        self.elements = self.elements.filter { (element) -> Bool in
            if element.coordinates.y < -self.cellSize {
                element.tearDown()
                
                return false
            } else {
                element.moveDown()
                
                return true
            }
        }
        // Check if new line must be rendered
        let deltaYBetweenLines = CGFloat(Map.numberOfCellsBetweenLines) * self.cellSize
        if let maxY = self.elements.last?.coordinates.y, self.height - maxY > deltaYBetweenLines  {
            self.addLine()
        }
    }
    
    func set(player: Player) {
        self.player = player
        self.addElement(element: player)
    }
    
    func removePlayer() {
        self.elements = Array(self.elements.drop { $0.type == .player })
    }
    
    func reset() {
        self.elements.forEach { $0.node.removeFromParent() }
        self.elements.removeAll()
    }
    
    private func addLine() {
        self.elementsGenerator.generateWallLine().forEach {
            self.addElement(element: $0)
        }
    }
    
    private func addElement(element: Element) {
        self.elements.append(element)
        self.scene.addChild(element.node)
    }
    
}
