import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scrambleLabel: UILabel!
    @IBOutlet weak var leftPad: UIButton!
    @IBOutlet weak var rightPad: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var performanceButton: UIButton!
    @IBOutlet weak var puzzleNameLabel: UILabel!
    @IBOutlet weak var changePuzzleButton: UIButton!
    
    private var viewModel = TimeViewModel()
    private var currentTime = Time()
    private var timer: Timer?
    
    @IBAction func tapPerformanceButton() {
        self.navigate.performance(puzzle: self.viewModel.getPuzzle())
    }
    
    @IBAction func touchUpInsideLeftPad() {
        self.viewModel.touchUpInsideLeft()
    }
    
    @IBAction func touchUpInsideRightPad() {
        self.viewModel.touchUpInsideRight()
    }
    
    @IBAction func touchUpDownLeftPad() {
        self.viewModel.touchDownInsideLeft()
    }
    
    @IBAction func touchUpDownRightPad() {
        self.viewModel.touchDownInsideRight()
    }
    
    @IBAction func tapResetButton() {
        self.stopTimer()
        self.self.timeLabel.text = "00:00.00"
        self.scrambleLabel.text = self.viewModel.getScrambleSequence()
        self.viewModel.resetTime()
        self.restartButton.animateSpinClick()
    }
    
    @IBAction func touchDownButton(sender: UIButton) {
        sender.animateClickPressed(options: .transitionCrossDissolve)
    }
    
    @IBAction func changePuzzle() {
        self.navigate.selectPuzzle(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.setUpDelegate(delegate: self)
        self.initialize()
        
    }
    
    @objc private func updateTimeLabel() {
        self.currentTime.addOneMilisecond()
        self.timeLabel.text = self.currentTime.toString()
    }
    
    private func initialize() {
        
        self.timeLabel.text = "00:00.00"
        self.timeLabel.font = StyleGuide.font.thirdTwoBold
        
        self.scrambleLabel.numberOfLines = 2
        self.scrambleLabel.text = self.viewModel.getScrambleSequence()
        self.scrambleLabel.font = StyleGuide.font.eighteen
        self.scrambleLabel.adjustsFontSizeToFitWidth = true
        
        self.leftPad.setImage(UIImage.init(named: "Hand Pad"), for: .normal)
        self.leftPad.setImage(UIImage.init(named: "Hand Pad Clicked"), for: .highlighted)
        
        self.rightPad.setImage(UIImage.init(named: "Hand Pad"), for: .normal)
        self.rightPad.setImage(UIImage.init(named: "Hand Pad Clicked"), for: .highlighted)
        self.rightPad.imageView!.transform = CGAffineTransform(rotationAngle: .pi/2)
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "noActionBackground")!)
        
        self.restartButton.rouded(radius: 41.5)
        self.restartButton.setImage(UIImage.init(named: "restartButton"), for: .normal)
        self.restartButton.addShadow()
        
        self.performanceButton.setImage(UIImage.init(named: "statisticsButton"), for: .normal)
        
        self.changePuzzleButton.setImage(UIImage.init(named: "changeButton"), for: .normal)
        
        self.puzzleNameLabel.text = self.viewModel.getPuzzle().rawValue
        self.puzzleNameLabel.font = StyleGuide.font.eighteenBold
        
    }
    
    func updateScreen(withPuzzle puzzle: puzzle) {
        self.timeLabel.text = "00:00.00"
        self.scrambleLabel.text = self.viewModel.getScrambleSequence()
        self.puzzleNameLabel.text = self.viewModel.getPuzzle().rawValue
    }

}

extension TimerViewController: TimeViewModelProtocol {
    
    func getTime() -> Time {
        return self.currentTime
    }
    
    func updateScramble(_ sequence: String) {
        self.scrambleLabel.text = self.viewModel.getScrambleSequence()
    }
    
    
    func startTimer() {
        self.currentTime = Time()
        self.currentTime.setScrambleSequence(self.scrambleLabel.text ?? " ")
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if let timer = self.timer {
            timer.invalidate()
        }
        self.timer = nil
    }
    
    func redDisplay() {
        self.view.animatedChangeImage(image: UIColor(patternImage: UIImage(named: "notReadyBackground")!))
    }
    
    func greenDisplay() {
        self.view.animatedChangeImage(image: UIColor(patternImage: UIImage(named: "readyBackground")!))
    }
    
    func displayOff() {
        self.view.animatedChangeImage(image: UIColor(patternImage: UIImage(named: "noActionBackground")!))
    }
    
}

extension TimerViewController: SelectPuzzleDelegate {
    
    func updatePuzzle(newPuzzle: puzzle) {
        self.viewModel.setPuzzel(newPuzzle: newPuzzle)
        self.updateScreen(withPuzzle: newPuzzle)
    }
    
}
