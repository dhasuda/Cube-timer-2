import UIKit

extension UIViewController {

    var navigate: Navigate {
        return Navigate.getSingleton(viewController: self)
    }
}
