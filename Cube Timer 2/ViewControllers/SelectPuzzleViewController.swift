import UIKit

protocol SelectPuzzleDelegate: class {
    func updatePuzzle(newPuzzle: puzzle)
}

class SelectPuzzleViewController: UIViewController {
    
    @IBOutlet weak var puzzlesCollection: UICollectionView!
    
    fileprivate var viewModel: SelectPuzzleViewModel!
    fileprivate var delegate: SelectPuzzleDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    private func initialize() {
        
        self.viewModel = SelectPuzzleViewModel()
        
        self.puzzlesCollection.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor.clear
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.frame
        
        self.view.insertSubview(blurView, at: 0)
        
        self.configureCollectionView()
        self.puzzlesCollection.reloadData()
        
    }
    
    func setUp(delegate: SelectPuzzleDelegate) {
        self.delegate = delegate
    }
    
    func configureCollectionView() {
        self.puzzlesCollection.delegate = self
        self.puzzlesCollection.dataSource = self
        
        if let layout = self.puzzlesCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: 140, height: 70)
        }
        
        let customCells = self.viewModel.getCustomCells
        
        _ = customCells.map {
            self.puzzlesCollection.register(UINib(nibName: $0, bundle: Bundle.main), forCellWithReuseIdentifier: $0)
        }
        
    }
    
    fileprivate func loadCell(_ indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = self.viewModel.sections[indexPath.section]
        var cell = UICollectionViewCell()
        
        let identifier = section.cellIdentifier(self.viewModel, indexPath: indexPath)
        cell = self.puzzlesCollection.dequeueReusableCell(withReuseIdentifier: identifier!, for: indexPath)
        
        if let cell = cell as? SelectPuzzleCollectionCell {
            cell.configureCell(self.viewModel, indexPath: indexPath)
        }
        
        return cell
    }
    
}

extension SelectPuzzleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfPuzzles()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.loadCell(indexPath)
        
        if let cell = cell as? SelectPuzzleCollectionCell {
            cell.delegate = self
        }
    
        return cell
    }
    
}

extension SelectPuzzleViewController: SelectPuzzleCollectionCellDelegate {
    
    func puzzleSelected(setting: PuzzleCellSetting) {
        self.delegate?.updatePuzzle(newPuzzle: setting.cellPuzzle)
        self.dismiss(animated: true, completion: nil)
    }
    
}
