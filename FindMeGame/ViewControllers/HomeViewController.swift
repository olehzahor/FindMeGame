//
//  HomeViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import Foundation

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
            
    @IBOutlet weak var startNewGameButton: UIButton! {
        didSet { makeRoundedCorners(startNewGameButton) }
    }
    
    @IBOutlet weak var aboutGameButton: UIButton! {
        didSet { makeRoundedCorners(aboutGameButton) }
    }
    
    @IBAction func startNewGame(_ sender: Any) {
        coordinator?.showGame()
    }
    
    @IBAction func showAboutInfo(_ sender: Any) {
        coordinator?.showAbout()
    }
    
    func makeRoundedCorners(_ view: UIView) {
        view.superview?.layer.cornerRadius = 16
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
