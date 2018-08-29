import Foundation
import QuartzCore

class SelectPuzzleViewModel {
    
    var getCustomCells: [String] {
        var cells = [String]()
        for _ in 0..<self.numberOfPuzzles() {
            cells.append(SelectPuzzleCollectionCell.reuseIdentifier)
        }
        return cells
    }
    
    var sections: [PuzzleSection] {
        return [
            PuzzleSection()
        ]
    }
    
    func numberOfPuzzles() -> Int {
        return 24
    }
    
    func getCellSetting(row: Int) -> PuzzleCellSetting {
        switch row {
        case 0:
            return PuzzleCellSetting(cellPuzzle: puzzle.twoByTwo, gradient: self.getGradient(At: row))
        case 1:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiks, gradient: self.getGradient(At: row))
        case 2:
            return PuzzleCellSetting(cellPuzzle: puzzle.fourByFour, gradient: self.getGradient(At: row))
        case 3:
            return PuzzleCellSetting(cellPuzzle: puzzle.fiveByFive, gradient: self.getGradient(At: row))
        case 4:
            return PuzzleCellSetting(cellPuzzle: puzzle.sixBySix, gradient: self.getGradient(At: row))
        case 5:
            return PuzzleCellSetting(cellPuzzle: puzzle.sevenBySeve, gradient: self.getGradient(At: row))
        case 6:
            return PuzzleCellSetting(cellPuzzle: puzzle.eightByEight, gradient: self.getGradient(At: row))
        case 7:
            return PuzzleCellSetting(cellPuzzle: puzzle.nineByNine, gradient: self.getGradient(At: row))
        case 8:
            return PuzzleCellSetting(cellPuzzle: puzzle.tenByTen, gradient: self.getGradient(At: row))
        case 9:
            return PuzzleCellSetting(cellPuzzle: puzzle.elevenByEleven, gradient: self.getGradient(At: row))
        case 10:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiksBlindfolded, gradient: self.getGradient(At: row))
        case 11:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiksOneHanded, gradient: self.getGradient(At: row))
        case 12:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiksWithFeet, gradient: self.getGradient(At: row))
        case 13:
            return PuzzleCellSetting(cellPuzzle: puzzle.megaminx, gradient: self.getGradient(At: row))
        case 14:
            return PuzzleCellSetting(cellPuzzle: puzzle.pyraminx, gradient: self.getGradient(At: row))
        case 15:
            return PuzzleCellSetting(cellPuzzle: puzzle.squareOne, gradient: self.getGradient(At: row))
        case 16:
            return PuzzleCellSetting(cellPuzzle: puzzle.skewb, gradient: self.getGradient(At: row))
        case 17:
            return PuzzleCellSetting(cellPuzzle: puzzle.gearCube, gradient: self.getGradient(At: row))
        case 18:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiksClock, gradient: self.getGradient(At: row))
        case 19:
            return PuzzleCellSetting(cellPuzzle: puzzle.siameseCube, gradient: self.getGradient(At: row))
        case 20:
            return PuzzleCellSetting(cellPuzzle: puzzle.twoByTwoBlindfolded, gradient: self.getGradient(At: row))
        case 21:
            return PuzzleCellSetting(cellPuzzle: puzzle.fourByFourBlindfolded, gradient: self.getGradient(At: row))
        case 22:
            return PuzzleCellSetting(cellPuzzle: puzzle.fiveByFiveBlindfolded, gradient: self.getGradient(At: row))
        case 23:
            return PuzzleCellSetting(cellPuzzle: puzzle.speedStacker, gradient: self.getGradient(At: row))
        default:
            return PuzzleCellSetting(cellPuzzle: puzzle.rubiks, gradient: self.getGradient(At: row))
        }
    }
    
    func getGradient(At row: Int) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        switch row % 9 {
        case 0:
            gradient.colors = StyleGuide.gradient.red
        case 1:
            gradient.colors = StyleGuide.gradient.darkBlue
        case 2:
            gradient.colors = StyleGuide.gradient.yellow
        case 3:
            gradient.colors = StyleGuide.gradient.lightGreen
        case 4:
            gradient.colors = StyleGuide.gradient.pink
        case 5:
            gradient.colors = StyleGuide.gradient.orange
        case 6:
            gradient.colors = StyleGuide.gradient.blue
        case 7:
            gradient.colors = StyleGuide.gradient.green
        case 8:
            gradient.colors = StyleGuide.gradient.green
        default:
            gradient.colors = StyleGuide.gradient.purple
        }
        return gradient
    }
    
}
