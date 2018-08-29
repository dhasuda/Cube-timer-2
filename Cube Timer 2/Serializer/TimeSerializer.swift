import Foundation

class TimeSerializer {
    
    public static func serialize(time: Time) -> String {
        
        var serialized = ""
        serialized += "\(time.getHours())*\(time.getMinutes())*\(time.getSeconds())*\(time.getMiliseconds())*\(time.getMonth())*\(time.getDay())*\(time.getYear())*\(time.getScrambleSequence())"
        return serialized
    }
    
    public static func deserialize(timeString: String) -> Time {
        
        let array = timeString.components(separatedBy: "*")
        
        let hours = Int(array[0]) ?? 0
        let minutes = Int(array[1]) ?? 0
        let seconds = Int(array[2]) ?? 0
        let miliseconds = Int(array[3]) ?? 0
        let month = Int(array[4]) ?? 0
        let day = Int(array[5]) ?? 0
        let year = Int(array[6]) ?? 0
        let scramble = array[7]
        
        return Time(miliseconds: miliseconds, seconds: seconds, minutes: minutes, hours: hours, month: month, day: day, year: year, scramble: scramble)
    }
    
}
