//
//  Coordinator.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }

    func start()
}
