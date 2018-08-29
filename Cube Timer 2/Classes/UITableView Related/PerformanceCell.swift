import UIKit
import QuartzCore

protocol PerformanceCellDelegate {
    
    func timeDeleted(indexPath: IndexPath)
    
}

class PerformanceCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scrambleSequenceLabel: UILabel!
    
    var delegate: PerformanceCellDelegate?
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configureCell(_ viewModel: PerformanceViewModel, indexPath: IndexPath) {
        
        self.timeLabel.font = StyleGuide.font.twenty
        self.timeLabel.textColor = StyleGuide.color.black66
        let index = viewModel.allTimes.count - indexPath.row - 1
        self.timeLabel.text = viewModel.allTimes[index].toString()
        
        self.scrambleSequenceLabel.numberOfLines = 0
        self.scrambleSequenceLabel.font = StyleGuide.font.fifteen
        self.scrambleSequenceLabel.textColor = StyleGuide.color.black42
        self.scrambleSequenceLabel.text = viewModel.allTimes[index].getScrambleSequence()
        
    }
    
}

