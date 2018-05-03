import Foundation
import SpriteKit

class ElementsGenerator {
    
    func generateWall(color: SKColor) -> Wall {
        let newElement = Wall()
        newElement.color = color
        return newElement
    }
    
    func generateRandomWall() -> Wall {
        return self.generateWall(color: WallColor.random.toColor())
    }
    
    func generateWallLine() -> [Wall] {
        let numberOfWall = (Map.numberOfColumns - 2).random + 2
        let randomXPositions = Array(0..<Map.numberOfColumns).sorted { _,_ in return arc4random() > arc4random()}
        print(randomXPositions)
        var line = [Wall]()
        
        for i in 0..<numberOfWall {
            let wall = self.generateRandomWall()
            wall.coordinates.x = Alignment(rawValue: CGFloat(randomXPositions[i]))!
            wall.coordinates.y = 800
            line.append(wall)
        }
        return line
    }
    
    
}
