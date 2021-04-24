//
//  GameViewModel.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class GameViewModel {
    private var game: Game
    
    private(set) var baseColor: UIColor = .green
    
    let defaults = UserDefaults.standard
    private let bestLevelUDKey = "FindMeGame_BestLevel"
    
    var elements: [UIColor] = []
    var level: String { String(game.currentLevel + 1) }
    var rows: Int { game.fieldSize.rows }
    var columns: Int { game.fieldSize.columns }
    
    var bestLevel: String {
        String(defaults.integer(forKey: bestLevelUDKey))
    }
    
    private func generateBaseColor() -> UIColor {
        let colors: [UIColor] = [.magenta, .orange, .yellow, .green, .blue, .cyan, .purple]
        return colors.randomElement() ?? .green
    }
    
    private func generateColors() -> [UIColor] {
        game.elements.map {
            switch $0 {
            case .regular:
                return baseColor
            case .different(let alpha):
                return baseColor.withAlphaComponent(CGFloat(alpha))
            }
        }
    }
    
    private func updateBestLevel() {
        if level > bestLevel {
            defaults.set(level, forKey: bestLevelUDKey)
        }
    }
    
    func didSelectElement(at index: Int) -> Bool {
        let isPassed = game.checkElement(atIndex: index)
        elements = generateColors()
        
        if isPassed {
            game.getToNextLevel()
        } else {
            game.reset()
            baseColor = generateBaseColor()
        }
        
        updateBestLevel()
        return isPassed
    }
    
    init(game: Game) {
        self.game = game
        self.baseColor = generateBaseColor()
        
        elements = generateColors()
    }
}
