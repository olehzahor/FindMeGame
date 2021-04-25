//
//  LoadingViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class LoadingViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    var resolver = Resolver(url: resolverUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resolver.askToResolve {
            if let url = $0 {
                self.coordinator?.showWebView(url)
            } else {
                self.coordinator?.showGame()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.viewControllers.removeAll { $0 == self}
    }
    
}