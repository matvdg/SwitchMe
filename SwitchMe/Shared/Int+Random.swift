import Foundation

extension Int {
    
    var random: Int {
        return Int(arc4random()) % self
    }
}


