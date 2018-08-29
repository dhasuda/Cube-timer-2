import Foundation

class PerformanceViewModel {
    
    var currentPuzzle: puzzle
    var allTimes: [Time]
    
    var sections: [PerformanceSection] {
        return [
            PerformanceSection()
        ]
    }
    
    var customCells: [String] {
        var cells = [String]()
        for _ in 0..<self.allTimes.count {
            cells.append(PerformanceCell.reuseIdentifier)
        }
        return cells
    }
    
    var header: String {
        return PerformanceSectionHeader.reuseIdentifier
    }
    
    init(puzzle: puzzle = .rubiks) {
        self.currentPuzzle = puzzle
        self.allTimes = TimeDAO.getTimes(self.currentPuzzle)
    }
    
    func changePuzzle(_ newPuzzle: puzzle) {
        self.currentPuzzle = newPuzzle
        self.allTimes = TimeDAO.getTimes(self.currentPuzzle)
    }
    
    func getAllTimes() -> [Time] {
        return self.allTimes
    }
    
    func getAverage() -> String {
        
        guard self.allTimes.count > 0 else {
            return "--:--.--"
        }
        
        var hours = 0
        var minutes = 0
        var seconds = 0
        var miliseconds = 0
        
        for time in self.allTimes {
            hours += time.getHours()
            minutes += time.getMinutes()
            seconds += time.getSeconds()
            miliseconds += time.getMiliseconds()
        }
        
        hours /= self.allTimes.count
        minutes /= self.allTimes.count
        seconds /= self.allTimes.count
        miliseconds /= self.allTimes.count
        
        return Time(miliseconds: miliseconds, seconds: seconds, minutes: minutes, hours: hours).toString()
        
    }
    
    func getPersonalBest() -> String {
        
        guard self.allTimes.count > 0 else {
            return "--:--.--"
        }
        
        var best = self.allTimes[0]
        
        for time in self.allTimes {
            if best.getMinutes() > time.getMinutes() {
                best = time
            } else if best.getMinutes() == time.getMinutes() {
                if best.getSeconds() > time.getSeconds() {
                    best = time
                } else if best.getSeconds() == time.getSeconds() {
                    if best.getMiliseconds() > time.getMiliseconds() {
                        best = time
                    }
                }
            }
        }
        
        return best.toString()
        
    }
    
    func getAverageOutOfFive() -> String {
        
        guard self.allTimes.count >= 5 else {
            return "--:--.--"
        }
        
        var hours = 0
        var minutes = 0
        var seconds = 0
        var miliseconds = 0
        let lastIndex = self.allTimes.count - 1
        
        for var i in 0..<5 {
            hours += self.allTimes[lastIndex-i].getHours()
            minutes += self.allTimes[lastIndex-i].getMinutes()
            seconds += self.allTimes[lastIndex-i].getSeconds()
            miliseconds += self.allTimes[lastIndex-i].getMiliseconds()
        }
        
        hours /= 5
        minutes /= 5
        seconds /= 5
        miliseconds /= 5
        
        return Time(miliseconds: miliseconds, seconds: seconds, minutes: minutes, hours: hours).toString()
        
    }
    
    func deleteTime(At index: Int) {
        TimeDAO.deleteTime(At: index, puzzle: self.currentPuzzle)
        self.allTimes = TimeDAO.getTimes(self.currentPuzzle)
    }
 
}
