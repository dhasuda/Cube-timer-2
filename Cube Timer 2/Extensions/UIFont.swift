import Foundation
import UIKit

extension UIFont {
    
    enum littleFootFont: String {
        case regular = ""
    }
    
    convenience init(LittleFoot: littleFootFont, fontSize: CGFloat) {
        self.init(name: LittleFoot.rawValue, size: fontSize)!
    }
    
}
