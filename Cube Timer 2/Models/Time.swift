import Foundation

class Time {
    
    private var hours: Int
    private var minutes: Int
    private var seconds: Int
    private var miliseconds: Int
    
    private var month: Int
    private var day: Int
    private var year: Int
    
    private var scramble: String
    
    init() {
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        self.miliseconds = 0
        
        let date = Date()
        self.month = NSCalendar.current.component(.month, from: date)
        self.day = NSCalendar.current.component(.day, from: date)
        self.year = NSCalendar.current.component(.year, from: date)
        
        self.scramble = " "
    }
    
    init(miliseconds: Int, seconds: Int, minutes: Int, hours: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.miliseconds = miliseconds
        
        let date = Date()
        self.month = NSCalendar.current.component(.month, from: date)
        self.day = NSCalendar.current.component(.day, from: date)
        self.year = NSCalendar.current.component(.year, from: date)
        
        self.scramble = " "
    }
    
    init(miliseconds: Int, seconds: Int, minutes: Int, hours: Int, month: Int, day: Int, year: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.miliseconds = miliseconds
        
        self.month = month
        self.day = day
        self.year = year
        
        self.scramble = " "
    }
    
    init(miliseconds: Int, seconds: Int, minutes: Int, hours: Int, month: Int, day: Int, year: Int, scramble: String) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        self.miliseconds = miliseconds
        
        self.month = month
        self.day = day
        self.year = year
        
        self.scramble = scramble
        if self.scramble.isEmpty {
            self.scramble = " "
        }
    }
    
    func setScrambleSequence(_ scramble: String) {
        guard !scramble.isEmpty else {
            self.scramble = " "
            return
        }
        self.scramble = scramble
    }
    
    func getScrambleSequence() -> String {
        return self.scramble
    }
    
    func getHours() -> Int {
        return self.hours
    }
    
    func getMinutes() -> Int {
        return self.minutes
    }
    
    func getSeconds() -> Int {
        return self.seconds
    }
    
    func getMiliseconds() -> Int {
        return self.miliseconds
    }
    
    func getMonth() -> Int {
        return self.month
    }
    
    func getDay() -> Int {
        return self.day
    }
    
    func getYear() -> Int {
        return self.year
    }
    
    func addOneMilisecond() {
        if (miliseconds < 99) { miliseconds += 1 }
        else {
            miliseconds = 0
            if (seconds < 59) { seconds += 1 }
            else {
                seconds = 0
                minutes += 1
            }
        }
    }
    
    func toString() -> String {
        var string = ""
        if (self.minutes < 10) { string += "0" }
        string += "\(self.minutes):"
        if (self.seconds < 10) { string += "0" }
        string += "\(self.seconds)."
        if (self.miliseconds < 10) { string += "0" }
        string += "\(self.miliseconds)"
        return string
    }
    
    func dateToString() -> String {
        return "\(self.month)/\(self.day)/\(self.year)"
    }
    
}
