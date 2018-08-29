import UIKit

class PerformanceSectionHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var label: UILabel!
    
    func configure() {
        self.label.numberOfLines = 1
        self.label.font = StyleGuide.font.thirdTwoBold
        self.label.textColor = StyleGuide.color.black
        self.label.text = "Times"
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
