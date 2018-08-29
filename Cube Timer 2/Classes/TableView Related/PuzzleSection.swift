import Foundation

class PuzzleSection {
    
    func cellIdentifier(_ viewModel: SelectPuzzleViewModel, indexPath: IndexPath) -> String? {
        return PuzzleViewCell.reuseIdentifier
    }
    
    func numberOfRows(_ viewModel: SelectPuzzleViewModel) -> Int {
        return viewModel.numberOfPuzzles()
    }
    
}
