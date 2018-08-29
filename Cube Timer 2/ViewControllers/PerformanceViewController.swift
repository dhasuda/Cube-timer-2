import UIKit

class PerformanceViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var averageTitleLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    @IBOutlet weak var personalBestTitleLabel: UILabel!
    @IBOutlet weak var personalBestTimeLabel: UILabel!
    @IBOutlet weak var fiveAverageTitleLabel: UILabel!
    @IBOutlet weak var fiveAverageTimeLabel: UILabel!
    @IBOutlet weak var changePuzzleButton: UIButton!
    @IBOutlet weak var timesTableView: UITableView!

    fileprivate var viewModel: PerformanceViewModel!
    
    @IBAction func changePuzzle() {
        self.navigate.selectPuzzle(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    func initialize() {
    
        self.navigationItem.title = "Performance"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.close))
        
        self.changePuzzleButton.setImage(UIImage.init(named: "changeButton"), for: .normal)
        
        self.titleLabel.numberOfLines = 2
        self.titleLabel.font = StyleGuide.font.thirdTwoBold
        self.titleLabel.textColor = StyleGuide.color.black
        self.titleLabel.text = self.viewModel.currentPuzzle.rawValue
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        self.averageTitleLabel.font = StyleGuide.font.twentyBold
        self.averageTitleLabel.textColor = StyleGuide.color.black66
        self.averageTitleLabel.text = "Average:"
        
        self.averageTimeLabel.font = StyleGuide.font.twenty
        self.averageTimeLabel.textColor = StyleGuide.color.black42
        self.averageTimeLabel.text = self.viewModel.getAverage()
        
        self.personalBestTitleLabel.font = StyleGuide.font.twentyBold
        self.personalBestTitleLabel.textColor = StyleGuide.color.black66
        self.personalBestTitleLabel.text = "Personal Best:"
        
        self.personalBestTimeLabel.font = StyleGuide.font.twenty
        self.personalBestTimeLabel.textColor = StyleGuide.color.black42
        self.personalBestTimeLabel.text = self.viewModel.getPersonalBest()
        
        self.fiveAverageTitleLabel.font = StyleGuide.font.twentyBold
        self.fiveAverageTitleLabel.textColor = StyleGuide.color.black66
        self.fiveAverageTitleLabel.text = "Average out of 5:"
        
        self.fiveAverageTimeLabel.font = StyleGuide.font.twenty
        self.fiveAverageTimeLabel.textColor = StyleGuide.color.black42
        self.fiveAverageTimeLabel.text = self.viewModel.getAverageOutOfFive()
        
        self.timesTableView.allowsSelection = false
        self.timesTableView.backgroundColor = UIColor.white
        self.configureTableView()
        self.timesTableView.reloadData()
        
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func updateBasicData() {
        self.averageTimeLabel.text = self.viewModel.getAverage()
        self.personalBestTimeLabel.text = self.viewModel.getPersonalBest()
        self.fiveAverageTimeLabel.text = self.viewModel.getAverageOutOfFive()
    }
    
    func setUpViewModel(puzzle: puzzle) {
        self.viewModel = PerformanceViewModel(puzzle: puzzle)
    }
    
    func configureTableView() {
        self.timesTableView.delegate = self
        self.timesTableView.dataSource = self
        
        self.timesTableView.estimatedRowHeight = 40
        
        let cells = self.viewModel.customCells
        
        _ = cells.map {
            self.timesTableView.register(UINib(nibName: $0, bundle: Bundle.main), forCellReuseIdentifier: $0)
        }
        
    }
    
    fileprivate func loadCell(_ indexPath: IndexPath) -> UITableViewCell {

        let section = self.viewModel.sections[indexPath.section]
        var cell = UITableViewCell()

        let identifier = section.cellIdentifier(self.viewModel, indexPath: indexPath)
        cell = self.timesTableView.dequeueReusableCell(withIdentifier: identifier!, for: indexPath)

        if let cell = cell as? PerformanceCell {
            cell.configureCell(self.viewModel, indexPath: indexPath)
        }

        return cell
    }

}

extension PerformanceViewController: SelectPuzzleDelegate {
    
    func updatePuzzle(newPuzzle: puzzle) {
        self.viewModel.changePuzzle(newPuzzle)
        self.initialize()
    }
    
}

extension PerformanceViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.allTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.loadCell(indexPath)
        
        if let cell = cell as? PerformanceCell {
            cell.delegate = self
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Times"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = viewModel.allTimes.count - indexPath.row - 1
            self.viewModel.deleteTime(At: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateBasicData()
        }
    }
    
}

extension PerformanceViewController: PerformanceCellDelegate {
    
    func timeDeleted(indexPath: IndexPath) {
        
    }
    
}

