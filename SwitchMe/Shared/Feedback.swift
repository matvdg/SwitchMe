import UIKit

class Feedback {
    
    static func die() {
        UIImpactFeedbackGenerator().impactOccurred()
    }
    
    static func collide() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
