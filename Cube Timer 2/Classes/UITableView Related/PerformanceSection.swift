import Foundation

import Foundation

class PerformanceSection {
    
    func cellIdentifier(_ viewModel: PerformanceViewModel, indexPath: IndexPath) -> String? {
        return PerformanceCell.reuseIdentifier
    }
    
    func numberOfRows(_ viewModel: PerformanceViewModel) -> Int {
        return viewModel.allTimes.count
    }
    
}
