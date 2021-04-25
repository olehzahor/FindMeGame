//
//  UDGameDataStore.swift
//  FindMeGame
//
//  Created by jjurlits on 4/25/21.
//

import Foundation

class UDGameDataStore: GameDataStore {
    let defaults = UserDefaults.standard
    private let bestLevelUDKey = "FindMeGame_BestLevel"
    
    func getBestLevel() -> Int {
        defaults.integer(forKey: bestLevelUDKey)
    }
    
    func saveBestLevel(_ value: Int) {
        defaults.set(value, forKey: bestLevelUDKey)
    }
}
