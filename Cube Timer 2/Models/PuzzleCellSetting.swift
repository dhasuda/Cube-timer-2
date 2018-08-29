import Foundation
import QuartzCore

class PuzzleCellSetting {
    
    var title: String
    var cellPuzzle: puzzle
    var gradient: CAGradientLayer
    
    init (cellPuzzle: puzzle, gradient: CAGradientLayer) {
        self.cellPuzzle = cellPuzzle
        self.title = cellPuzzle.rawValue
        self.gradient = gradient
    }
    
}
