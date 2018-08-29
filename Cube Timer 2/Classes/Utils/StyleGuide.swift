import Foundation
import UIKit

class StyleGuide {

    struct color {
        
        static let black = UIColor.black
        static let white = UIColor.white
        static let red = UIColor.red
        static let green = UIColor.green
        
        static let black66 = UIColor.black.withAlphaComponent(0.66)
        static let black42 = UIColor.black.withAlphaComponent(0.42)
        
    }
    
    struct font {
        
        static let fifteen = UIFont(name: "DevanagariSangamMN", size: 15)
        static let eighteen = UIFont(name: "DevanagariSangamMN", size: 18)
        static let twenty = UIFont(name: "DevanagariSangamMN", size: 20)
        
        static let eighteenBold = UIFont(name: "DevanagariSangamMN-Bold", size: 18)
        static let twentyBold = UIFont(name: "DevanagariSangamMN-Bold", size: 20)
        static let twentyEightBold = UIFont(name: "DevanagariSangamMN-Bold", size: 28)
        static let thirdTwoBold = UIFont(name: "DevanagariSangamMN-Bold", size: 32)
        static let fortyBold = UIFont(name: "DevanagariSangamMN-Bold", size: 40)
        
    }
    
    struct gradient {
        
        static let red = [UIColor(hex: 0xFF0026).cgColor, UIColor(hex: 0xFF0186).cgColor]
        static let pink = [UIColor(hex: 0xAF08DB).cgColor, UIColor(hex: 0xFF00DD).cgColor]
        static let yellow = [UIColor(hex: 0xFFC400).cgColor, UIColor(hex: 0xFBFF00).cgColor]
        static let blue = [UIColor(hex: 0x00B5FF).cgColor, UIColor(hex: 0x00ECFF).cgColor]
        static let darkBlue = [UIColor(hex: 0x0007FF).cgColor, UIColor(hex: 0x318DFF).cgColor]
        static let orange = [UIColor(hex: 0xFF4E00).cgColor, UIColor(hex: 0xFFB108).cgColor]
        static let lightGreen = [UIColor(hex: 0x39FF00).cgColor, UIColor(hex: 0xA3FF00).cgColor]
        static let green = [UIColor(hex: 0x00D3FF).cgColor, UIColor(hex: 0x08FFC1).cgColor]
        static let purple = [UIColor(hex: 0xC808FF).cgColor, UIColor(hex: 0x8C00FF).cgColor]
        
    }
    
}
