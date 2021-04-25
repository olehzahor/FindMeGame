//
//  GameDataStore.swift
//  FindMeGame
//
//  Created by jjurlits on 4/25/21.
//

import Foundation

protocol GameDataStore {
    func getBestLevel() -> Int
    func saveBestLevel(_ value: Int)
}
