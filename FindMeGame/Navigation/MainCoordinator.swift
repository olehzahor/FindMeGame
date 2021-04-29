//
//  MainCoordinator.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit
import WebKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationBar()
    }

    func start() {
        let vc = LoadingViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showHome() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showGame() {
        let vc = GameViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showWebView(_ url: URL) {
        let vc = WebViewController.instantiate()
        vc.url = url
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAbout() {
        let vc = AboutViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator {
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()

        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .clear

        navigationController.navigationBar.standardAppearance = navigationBarAppearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController.navigationBar.compactAppearance = navigationBarAppearance

        navigationController.navigationBar.prefersLargeTitles = false
    }
}
