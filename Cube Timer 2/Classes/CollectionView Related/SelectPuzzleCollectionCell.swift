import UIKit
import QuartzCore

protocol SelectPuzzleCollectionCellDelegate {
    
    func puzzleSelected(setting: PuzzleCellSetting)
    
}

class SelectPuzzleCollectionCell: UICollectionViewCell {
    
    let ROUNDED_RADIUS: CGFloat = 24
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var topDistance: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    var setting: PuzzleCellSetting!
    
    var delegate: SelectPuzzleCollectionCellDelegate?
    
    @IBAction func buttonPressed() {
        self.delegate?.puzzleSelected(setting: self.setting)
    }
    
    class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configureCell(_ viewModel: SelectPuzzleViewModel, indexPath: IndexPath) {
        
        self.setting = viewModel.getCellSetting(row: indexPath.row)
        
        self.titleLabel.text = self.setting.title
        self.titleLabel.font = StyleGuide.font.twentyBold
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textColor = UIColor.white
        
        self.button.setTitle("", for: .normal)
        self.button.rouded(radius: ROUNDED_RADIUS)
        self.button.alpha = 0.6
        self.button.backgroundColor = UIColor.clear
        self.button.backgroundColor = UIColor.black
        self.button.layer.sublayers?.popLast()
        
        let gradient = self.setting.gradient
        gradient.isOpaque = false
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0.7, y: 0)
        gradient.cornerRadius = ROUNDED_RADIUS
        gradient.frame = self.button.bounds
        
        self.button.layer.insertSublayer(gradient, at: 0)
        
//        self.topDistance.constant = indexPath.row < 4 ? 100 : 0
        self.topDistance.constant = 16
        
    }
    
}
