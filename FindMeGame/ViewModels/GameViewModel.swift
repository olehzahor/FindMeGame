//
//  GameViewModel.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class ColorGenerator {
    var baseColors: [UIColor] = [.purple]
    
    func generateBaseColor() -> UIColor {
        return baseColors.randomElement() ?? .purple
    }
    
    func generate(baseColor: UIColor, alphas: [CGFloat]) -> [UIColor] {
        alphas.map { baseColor.withAlphaComponent($0) }
    }
}

class GameViewModel {
    private var game: Game
    private var store: GameDataStore = UDGameDataStore()
    private var colorGenerator = ColorGenerator()
    
    private(set) var state: State = .undefined
    
    private(set) var baseColor: UIColor = .purple
    private(set) var elements: [UIColor] = []
    
    var level: String { String(_level) }
    var bestLevel: String { String(_bestLevel) }
    
    var rows: Int { game.fieldSize.rows }
    var columns: Int { game.fieldSize.columns }
    
    private var _bestLevel: Int { store.getBestLevel() }
    private var _level: Int { game.currentLevel + 1 }
    
    private func generateBaseColor() {
        baseColor = colorGenerator.generateBaseColor()
    }
    
    private func generateColors() -> [UIColor] {
        colorGenerator.generate(
            baseColor: baseColor,
            alphas: game.elements.map { $0.alpha} )
    }

    private func recreateElements() {
        elements = generateColors()
    }
    
    private func updateBestLevel() {
        if game.currentLevel + 1 > _bestLevel {
            store.saveBestLevel(game.currentLevel)
        }
    }
    
    private func getToNextLevel() {
        game.getToNextLevel()
        recreateElements()
        updateBestLevel()
    }
    
    func didSelectElement(at index: Int) {
        let isPassed = game.checkElement(atIndex: index)
        
        if isPassed {
            if !game.isOnLastLevel {
                getToNextLevel()
            } else { state = .won }
        } else {
            state = .failed
        }
    }
    
    func failGame() {
        state = .failed
    }
    
    func startNewGame() {
        game.reset()
        recreateElements()
        generateBaseColor()
        state = .inProgress
    }
    
    init(game: Game) {
        self.game = game
        generateBaseColor()
    }
}

extension GameViewModel {
    enum State {
        case undefined
        case inProgress
        case won
        case failed
    }
}

extension Game.Element {
    var alpha: CGFloat {
        switch self {
        case .regular:
            return CGFloat(1)
        case .different(let alpha):
            return CGFloat(alpha)
        }
    }
}
