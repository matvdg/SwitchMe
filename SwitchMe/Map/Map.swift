import UIKit
import SpriteKit

class Map {
    
    static let numberOfColumns = Alignment.count
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
    static let numberOfCellsBetweenLines = 6
    
    static var cellSize: CGFloat {
        // +1 for half a column each side as margin
        return width / CGFloat(numberOfColumns + 1)
    }
    
    var elements = [Element]()
    var scene: SKScene
    var player: Player!
    
    init(scene: SKScene) {
        self.scene = scene
    }
    
    func render() {
        // FIXME: all following actions are done by the player element too
        self.elements = self.elements.filter { (element) -> Bool in
            if element.coordinates.y < -Map.cellSize {
                element.tearDown()
                
                return false
            } else {
                element.moveDown()
                
                return true
            }
        }
        // Check if new line must be rendered
        let deltaYBetweenLines = CGFloat(Map.numberOfCellsBetweenLines) * Map.cellSize
        if let maxY = self.elements.last?.coordinates.y, Map.height - maxY > deltaYBetweenLines  {
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
        ElementsGenerator().generateWallLine().forEach {
            self.addElement(element: $0)
        }
    }
    
    private func addElement(element: Element) {
        self.elements.append(element)
        self.scene.addChild(element.node)
    }
    
}
