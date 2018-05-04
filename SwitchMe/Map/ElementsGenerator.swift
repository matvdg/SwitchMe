import Foundation
import SpriteKit

class ElementsGenerator {
    
    let minimumWallsPerLine = 3
    let maximumWallsPerLine = Map.numberOfColumns
    
    func generateWall(color: SKColor) -> Wall {
        let newElement = Wall()
        newElement.color = color
        return newElement
    }
    
    func generateRandomWall() -> Wall {
        return self.generateWall(color: WallColor.random.toColor())
    }
    
    func generateWallLine() -> [Wall] {
        let numberOfWall = (Map.numberOfColumns - (self.maximumWallsPerLine - self.minimumWallsPerLine)).random + self.minimumWallsPerLine
        let randomXPositions = Array(0..<Map.numberOfColumns).sorted { _,_ in return arc4random() > arc4random()}
        var line = [Wall]()
        
        for i in 0..<numberOfWall {
            let wall = self.generateRandomWall()
            wall.coordinates.x = Alignment(rawValue: CGFloat(randomXPositions[i]))!
            wall.coordinates.y = Map.height + Map.cellSize
            line.append(wall)
        }
        
        let numberOfUnbreakableWalls = line.reduce(0) { (count, wall) -> Int in
            if wall.color == .black { return count + 1}
            return count
        }
        if numberOfUnbreakableWalls >= Map.numberOfColumns {
            let randomWallToDelete = Map.numberOfColumns.random
            line.remove(at: randomWallToDelete)
        }
        
        return line
    }
    
    
}
