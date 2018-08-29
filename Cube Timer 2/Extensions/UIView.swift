import UIKit

extension UIView {
    
    func animatedChangeImage(image: UIColor) {
        UIView.transition(with: self,
                          duration: 0.3,
                          options: [.transitionCrossDissolve, .allowUserInteraction],
                          animations: { self.backgroundColor = image },
                          completion: nil)
    }
    
}
