import Foundation

enum state: Int {
    case notStarted
    case canStart
    case started
    case stopped
}

class StateMachine {
    
    private var currentState: state
    
    init() {
        self.currentState = state.notStarted
    }
    
    func getCurrentState() -> state {
        return self.currentState
    }
    
    func nextState() {
        guard self.currentState != state.stopped else {
            return
        }
        self.currentState = state(rawValue: self.currentState.rawValue + 1)!
    }
    
    func resetStateMachine() {
        self.currentState = state.notStarted
    }
    
}
