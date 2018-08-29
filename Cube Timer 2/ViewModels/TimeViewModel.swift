import Foundation

protocol TimeViewModelProtocol: class {
    
    func startTimer()
    func stopTimer()
    func redDisplay()
    func greenDisplay()
    func displayOff()
    func updateScramble(_ sequence: String)
    func getTime() -> Time
    
}

class TimeViewModel {
    
    private var delegate: TimeViewModelProtocol? = nil
    private let stateMachine = StateMachine()
    private var leftTouches = 0
    private var rightTouches = 0
    private var currentPuzzle = puzzle.rubiks
    
    func setPuzzel(newPuzzle: puzzle) {
        self.currentPuzzle = newPuzzle
    }
    
    func getPuzzle() -> puzzle {
        return self.currentPuzzle
    }
 
    func setUpDelegate(delegate: TimeViewModelProtocol) {
        self.delegate = delegate
    }
    
    func touchUpInsideLeft() {
        self.leftTouches += 1
        
        guard rightTouches > 0 else {
            self.delegate?.redDisplay()
            return
        }
        
        switch self.stateMachine.getCurrentState() {
        case .notStarted:
            self.stateMachine.nextState()
            self.delegate?.greenDisplay()
        case .started:
            self.stateMachine.nextState()
            self.delegate?.stopTimer()
            TimeDAO.saveNewTime(self.delegate!.getTime(), puzzle: self.currentPuzzle)
        default:
            return
        }
    }
    
    func touchUpInsideRight() {
        self.rightTouches += 1
        
        guard leftTouches > 0 else {
            self.delegate?.redDisplay()
            return
        }
        
        switch self.stateMachine.getCurrentState() {
        case .notStarted:
            self.stateMachine.nextState()
            self.delegate?.greenDisplay()
        case .started:
            self.stateMachine.nextState()
            self.delegate?.stopTimer()
            TimeDAO.saveNewTime(self.delegate!.getTime(), puzzle: self.currentPuzzle)
        default:
            return
        }
    }
    
    func touchDownInsideLeft() {
        self.leftTouches -= 1
        if self.leftTouches < 0 {
            self.leftTouches = 0
        }
        
        guard self.stateMachine.getCurrentState() == state.canStart else {
            if self.rightTouches == 0 {
                self.delegate?.displayOff()
            }
            return
        }
        
        if self.leftTouches ==  0 {
            self.stateMachine.nextState()
            self.delegate?.startTimer()
            self.delegate?.displayOff()
        }
    }
    
    func touchDownInsideRight() {
        self.rightTouches -= 1
        if self.rightTouches < 0 {
            self.rightTouches = 0
        }
        
        guard self.stateMachine.getCurrentState() == state.canStart else {
            if self.leftTouches == 0 {
                self.delegate?.displayOff()
            }
            return
        }
        
        if self.rightTouches ==  0 {
            self.stateMachine.nextState()
            self.delegate?.startTimer()
            self.delegate?.displayOff()
        }
    }
    
    func resetTime() {
        self.stateMachine.resetStateMachine()
        self.leftTouches = 0
        self.rightTouches = 0
    }
    
    func getScrambleSequence() -> String {
        var possibleMoves: [String] = [String]()
        var numberOfMoves: Int
        
        switch self.currentPuzzle {
        case .twoByTwo, .twoByTwoBlindfolded:
            numberOfMoves = 9
            possibleMoves = ["U", "U2", "U'", "F", "F2", "F'", "R", "R2", "R'", "L", "L2", "L'", "D", "D2", "D'", "B", "B2", "B'"]
        case .rubiks, .rubiksBlindfolded, .rubiksOneHanded, .rubiksWithFeet:
            numberOfMoves = 25
            possibleMoves = ["U", "U2", "U'", "F", "F2", "F'", "R", "R2", "R'", "L", "L2", "L'", "D", "D2", "D'", "B", "B2", "B'"]
        case .fourByFour, .fourByFourBlindfolded:
            numberOfMoves = 40
            possibleMoves = ["U", "U2", "U'", "F", "F2", "F'", "R", "R2", "R'", "L", "L2", "L'", "D", "D2", "D'", "B", "B2", "B'", "Uw", "Uw2", "Uw'", "Fw", "Fw2", "Fw'", "Rw", "Rw2", "Rw'", "Lw", "Lw2", "Lw'", "Dw", "Dw2", "Dw'", "Bw", "B2w", "Bw'"]
        case .fiveByFive, .fiveByFiveBlindfolded:
            numberOfMoves = 60
            possibleMoves = ["U", "U2", "U'", "F", "F2", "F'", "R", "R2", "R'", "L", "L2", "L'", "D", "D2", "D'", "B", "B2", "B'", "Uw", "Uw2", "Uw'", "Fw", "Fw2", "Fw'", "Rw", "Rw2", "Rw'", "Lw", "Lw2", "Lw'", "Dw", "Dw2", "Dw'", "Bw", "B2w", "Bw'"]
        case .skewb:
            numberOfMoves = 25
            possibleMoves = ["F", "F'", "R", "R'", "L", "L'", "B", "B'"]
        case .speedStacker:
            return ""
        default:
            return ""
        }
        return scramble(possibleMoves: possibleMoves, numberOfMoves: numberOfMoves)
    }
    
    private func scramble(possibleMoves: [String], numberOfMoves: Int) -> String {
        var sequence: String = ""
        let size: Int = possibleMoves.count - 1
        
        var lastMovement = "  "
        
        for _ in 1..<numberOfMoves {
            var randomIndex = Int(arc4random_uniform(UInt32(size)))
            
            while possibleMoves[randomIndex].contains(lastMovement) || lastMovement.contains(possibleMoves[randomIndex]) {
                randomIndex = Int(arc4random_uniform(UInt32(size)))
            }
            
            sequence += (possibleMoves[randomIndex] + "  ")
            lastMovement = possibleMoves[randomIndex]
        }
        
        let randomIndex = Int(arc4random_uniform(UInt32(size)))
        sequence += possibleMoves[randomIndex]
        
        return (sequence)
        
    }
    
}
