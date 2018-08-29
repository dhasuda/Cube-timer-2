import UIKit

extension UIButton {

    func rouded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        
    }
    
    func addShadow() {
        self.layer.cornerRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
    }
    
    func animateClickPressed(options: UIViewAnimationOptions) {
        UIView.transition(with: self,
                          duration: 0.1,
                          options: options,
                          animations: { self.isHighlighted = true },
                          completion: nil)
    }
    
    func animateClickNotPressed(options: UIViewAnimationOptions) {
        UIView.transition(with: self,
                          duration: 0.2,
                          options: options,
                          animations: { self.isSelected = false },
                          completion: nil)
    }
    
    func animateSpinClick() {
        
        UIView.animate(withDuration: 0.15) { () -> Void in
            self.transform = CGAffineTransform(rotationAngle: -0.5 * .pi)
        }
        
        UIView.animate(withDuration: 0.15, delay: 0.1, options: .curveLinear, animations: { () -> Void in
            self.transform = CGAffineTransform(rotationAngle: .pi)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.3, delay: 0.20, options: .curveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransform(rotationAngle: .pi * -2.0)
        }, completion: nil)
        
    }
    
}
