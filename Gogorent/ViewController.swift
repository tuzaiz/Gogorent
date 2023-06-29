//
//  ViewController.swift
//  Gogorent
//
//  Created by Henry Tseng on 2023/6/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        present(ImageShuffleViewController(), animated: true)
    }
}

