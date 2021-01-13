//
//  SelfCareController.swift
//  Zen
//
//  Created by Haotian Ye on 1/12/21.
//

import Foundation
import UIKit

var chosen = ""

class SelfCareController: UIViewController {
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yogaPressed(_ sender: Any) {
        chosen = "yoga"
        self.performSegue(withIdentifier: "ArticleSegue", sender: self)
    }
    
    @IBAction func walksPressed(_ sender: Any) {
        chosen = "walks"
        self.performSegue(withIdentifier: "ArticleSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}
