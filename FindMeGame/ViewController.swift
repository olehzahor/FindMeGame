//
//  ViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { setupCollectionView() }
    }
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var bestLevelLabel: UILabel!
    
    var gameViewModel = GameViewModel(game: Game(fieldSize: .init(rows: 8, columns: 5), levelsCount: 50))
    var cellSize = CGSize(width: 50, height: 50)
    var cellSpacing = CGFloat(2)
    
    private func updateUI() {
        collectionView.reloadData()
        levelLabel.text = gameViewModel.level
        bestLevelLabel.text = gameViewModel.bestLevel
    }
    
    private func setupCollectionView() {
        collectionView.layer.cornerRadius = 16
        collectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
    }
                
    private func adjustCellSize() {
        let columnsCount = CGFloat(gameViewModel.columns)
        let rowsCount = CGFloat(gameViewModel.rows)
        
        cellSize.width = (collectionView.bounds.size.width - collectionView.contentInset.left - collectionView.contentInset.right - columnsCount * cellSpacing) / columnsCount
        cellSize.height = (collectionView.bounds.size.height - collectionView.contentInset.top - collectionView.contentInset.bottom - rowsCount * cellSpacing) / rowsCount
    }
    
    override func viewDidLayoutSubviews() {
        adjustCellSize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "Cell")
        
        updateUI()
    }
}


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameViewModel.didSelectElement(at: indexPath.row)
        updateUI()
    }
}

extension ViewController: UICollectionViewDataSource {
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

extension ViewController: UICollectionViewDelegateFlowLayout {
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
