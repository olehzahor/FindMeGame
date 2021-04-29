//
//  WebViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    var url: URL?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
