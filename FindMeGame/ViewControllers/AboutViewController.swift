//
//  AboutViewController.swift
//  FindMeGame
//
//  Created by jjurlits on 4/24/21.
//

import UIKit

class AboutViewController: UIViewController, Storyboarded {
    @IBOutlet weak var textView: UITextView!
    
    private func loadTextFromBundle(filename: String) -> String {
        if let filepath = Bundle.main.path(forResource: filename, ofType: "txt") {
            let contents = try? String(contentsOfFile: filepath)
            return contents ?? ""
        } else {
            return ""
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = loadTextFromBundle(filename: "about")
    }
}
