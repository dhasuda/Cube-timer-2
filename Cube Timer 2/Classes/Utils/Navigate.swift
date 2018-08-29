import UIKit

public class Navigate {
    
    fileprivate static var instance: Navigate?
    fileprivate var viewController: UIViewController!
    
    enum storyboard: String {
        case timer = "Timer"
        case performance = "Performance"
        case selectPuzzle = "SelectPuzzle"
    }
    
    enum screen: String {
        case timerScreen = "TimerViewController"
        case performance = "PerformanceViewController"
        case selectPuzzle = "SelectPuzzle"
    }
    
    fileprivate init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    class func getSingleton(viewController: UIViewController) -> Navigate {
        
        if let instance = self.instance {
            instance.viewController = viewController
            return instance
        }
        
        return Navigate(viewController: viewController)
        
    }
    
    fileprivate func getStoryboard(screen: screen) -> storyboard {
        switch screen {
        case .timerScreen:
            return .timer
        case .performance:
            return .performance
        case .selectPuzzle:
            return .selectPuzzle
        }
    }
    
    func instantiate(screen: screen) -> UIViewController {
        let storyboard = UIStoryboard(name: self.getStoryboard(screen: screen).rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: screen.rawValue)
    }
    
    func instantiateWithNavigationController(screen: screen) -> UIViewController {
        let storyboard = UIStoryboard(name: self.getStoryboard(screen: screen).rawValue, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: screen.rawValue)
        return UINavigationController(rootViewController: controller)
    }
    
    func present(screen: screen, animated: Bool = true) {
        let viewController = self.instantiate(screen: screen)
        viewController.modalPresentationStyle = .fullScreen
        self.viewController.present(viewController, animated: animated, completion: nil)
    }
    
}

extension Navigate {
    
    func timer() {
        let timerViewController = self.instantiate(screen: .timerScreen)
        let nav = UINavigationController(rootViewController: timerViewController)
        self.viewController.present(nav, animated: true, completion: nil)
    }
    
    func performance(puzzle: puzzle) {
        let vc = self.instantiate(screen: .performance) as! PerformanceViewController
        vc.setUpViewModel(puzzle: puzzle)
        let nav = UINavigationController(rootViewController: vc)
        self.viewController.present(nav, animated: true, completion: nil)
//        self.viewController.present(vc, animated: true, completion: nil)
    }
    
    func selectPuzzle(delegate: SelectPuzzleDelegate) {
        let vc = self.instantiate(screen: .selectPuzzle) as! SelectPuzzleViewController
        vc.setUp(delegate: delegate)
        vc.modalPresentationStyle = .overFullScreen
        self.viewController.present(vc, animated: true, completion: nil)
    }
    
}
