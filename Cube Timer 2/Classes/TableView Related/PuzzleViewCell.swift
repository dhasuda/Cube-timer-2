import UIKit

protocol SelectPuzzleCellDelegate: class {
    
}

class PuzzleViewCell: UITableViewCell {
    
    
    
    var delegate: SelectPuzzleCellDelegate?
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configureCell(_ viewModel: PerformanceViewModel, indexPath: IndexPath) {
        
    }
    
}
