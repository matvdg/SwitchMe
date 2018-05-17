import Foundation
import SpriteKit

class ElementsGenerator {
    
    let minimumWallsPerLine = Game.config["minimumWallsPerLine"] as! Int
    let maximumWallsPerLine = Int(Map.numberOfColumns)
    let mapNumberOfColumns = Int(Map.numberOfColumns)
    let map: Map
    
    init(map: Map) {
        self.map = map
    }
    
    func generateWall(color: SKColor) -> Wall {
        let wallPosition = CGPoint.zero
        let wallSize = CGSize(width: self.map.cellSize, height: self.map.cellSize)
        let wall = Wall(initialPosition: wallPosition, size: wallSize)
        
        wall.color = color
        
        return wall
    }
    
    func generateRandomWall() -> Wall {
        return self.generateWall(color: WallColor.random.toColor())
    }
    
    func generateWallLine() -> [Wall] {
        let numberOfWall = (self.mapNumberOfColumns - (self.maximumWallsPerLine - self.minimumWallsPerLine)).random + self.minimumWallsPerLine
        let randomXPositions = Array(0..<self.mapNumberOfColumns).sorted { _,_ in return arc4random() > arc4random()}
        var line = [Wall]()
        
        for i in 0..<numberOfWall {
            let wall = self.generateRandomWall()
            wall.coordinates.x = CGFloat(randomXPositions[i]) * self.map.cellSize
            wall.coordinates.y = self.map.height + self.map.cellSize
            line.append(wall)
        }
        
        let numberOfUnbreakableWalls = line.reduce(0) { (count, wall) -> Int in
            if wall.color == .black { return count + 1}
            return count
        }
        
        if numberOfUnbreakableWalls >= self.mapNumberOfColumns {
            let randomWallToDelete = self.mapNumberOfColumns.random
            line.remove(at: randomWallToDelete)
        }
        
        return line
    }
    
    
}
