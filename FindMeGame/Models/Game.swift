//
//  Game.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import Foundation

struct Game {
    let fieldSize: FieldSize
    let levelsCount: Int
    
    private let baseOpacity = 0.6
    
    private(set) var currentLevel: Int = 0 {
        didSet { generateElements() }
    }
    private(set) var elements: [Element] = []
    
    private func createDifferentElement() -> Element {
        let opacity = baseOpacity + (0.98 - baseOpacity) * Double(currentLevel) / Double(levelsCount)
        return Element.different(opacity)
    }
    
    mutating func generateElements() {
        elements = [Element](repeating: .regular,
                             count: fieldSize.linearSize)
        if let randomIndex = elements.indices.randomElement() {
            elements[randomIndex] = createDifferentElement()
        }
    }
    
    mutating func getToNextLevel() {
        if currentLevel < levelsCount {
            currentLevel += 1
        }
    }
    
    mutating private func check(_ element: Element) -> Bool {
        switch element {
        case .regular:
            return false
        case .different(_):
            return true
        }
    }
    
    mutating func checkElement(atIndex index: Int) -> Bool {
        check(elements[index])
    }
    
    mutating func reset() {
        currentLevel = 0
    }
    
    init(fieldSize: Game.FieldSize, levelsCount: Int) {
        self.fieldSize = fieldSize
        self.levelsCount = levelsCount

        generateElements()
    }
}

extension Game {
    struct FieldSize {
        let rows: Int
        let columns: Int
        
        var linearSize: Int {
            rows * columns
        }
    }
}


extension Game {
    enum Element {
        case regular
        case different(Double)
    }
}
