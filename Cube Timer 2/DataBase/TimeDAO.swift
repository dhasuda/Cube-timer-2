import Foundation

class TimeDAO {
    
    static let timesKey = "TIMES_KEY"
    
    class func getTimes(_ puzzle: puzzle) -> [Time] {
        
        let bunchOfTimesString = UserDefaults().stringArray(forKey: TimeDAO.timesKey + puzzle.rawValue) ?? [String]()
        var bunchOfTimes = [Time]()
        for var time in bunchOfTimesString {
            bunchOfTimes.append(TimeSerializer.deserialize(timeString: time))
        }
        
        return bunchOfTimes
    }
    
    class func saveNewTime(_ time: Time, puzzle: puzzle) {
        
        let timesArray = TimeDAO.getTimes(puzzle)
        var timesArrayString = [String]()
        for var oldTime in timesArray {
            timesArrayString.append(TimeSerializer.serialize(time: oldTime))
        }
        timesArrayString.append(TimeSerializer.serialize(time: time))
        UserDefaults().set(timesArrayString, forKey: TimeDAO.timesKey + puzzle.rawValue)
        
    }
    
    class func deleteTime(At index: Int, puzzle: puzzle) {
        
        let timesArray = TimeDAO.getTimes(puzzle)
        var timesArrayString = [String]()
        
        for var oldTime in timesArray {
            timesArrayString.append(TimeSerializer.serialize(time: oldTime))
        }
        timesArrayString.remove(at: index)
        
        UserDefaults().set(timesArrayString, forKey: TimeDAO.timesKey + puzzle.rawValue)
        
    }
    
}
