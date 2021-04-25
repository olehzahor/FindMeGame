//
//  ViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class GameViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { setupCollectionView() }
    }
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bestLevelLabel: UILabel!
    
    var gameViewModel = GameViewModel(game: Game(fieldSize: .init(rows: 8, columns: 5), levelsCount: 50))
    var cellSize = CGSize(width: 50, height: 50)
    var cellSpacing = CGFloat(2)

    var totalTime: Int = 30
    private(set) var timeLeft: Int = 0 {
        didSet { updateTimerUI() }
    }
    
    private var timer: Timer?

    @IBAction func startNewGame(_ sender: Any) {
        startNewGame()
    }
        
    private func handleFail() {
        stopTimer()
        title = "Game Over!"
    }
    
    private func handleWin() {
        stopTimer()
        title = "You Won!"
    }
    
    private func updateUI() {
        collectionView.reloadData()
        levelLabel.text = gameViewModel.level
        bestLevelLabel.text = gameViewModel.bestLevel
        
        switch gameViewModel.state {
        case .failed:
            handleFail()
        case .won:
            handleWin()
        default:
            break
        }
    }
    
    private func setupCollectionView() {
        collectionView.layer.cornerRadius = 16
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "Cell")
    }
                
    func startNewGame(shoudStartTimer: Bool = true) {
        gameViewModel.startNewGame()
        updateUI()
        if shoudStartTimer { startTimer() }
    }
    
    override func viewDidLayoutSubviews() {
        adjustCellSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame(shoudStartTimer: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if timer == nil { startTimer() }
    }
}

extension GameViewController {
    @objc func fireTimer() {
        if timeLeft > 0 { timeLeft -= 1 }
        else {
            timer?.invalidate()
            gameViewModel.failGame()
            updateUI()
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timeLeft = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() { timer?.invalidate() }
    
    private func updateTimerUI() {
        title = "Time Left: \(timeLeft)s"
    }
}


extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard gameViewModel.state == .inProgress else { return }
        gameViewModel.didSelectElement(at: indexPath.row)
        updateUI()
    }
}

extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameViewModel.elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let color = gameViewModel.elements[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    private func adjustCellSize() {
        let columnsCount = CGFloat(gameViewModel.columns)
        let rowsCount = CGFloat(gameViewModel.rows)
        
        cellSize.width = (collectionView.bounds.size.width - collectionView.contentInset.left - collectionView.contentInset.right - columnsCount * cellSpacing) / columnsCount
        cellSize.height = (collectionView.bounds.size.height - collectionView.contentInset.top - collectionView.contentInset.bottom - rowsCount * cellSpacing) / rowsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        cellSpacing
    }
}
