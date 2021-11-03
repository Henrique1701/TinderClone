//
//  MatchVC.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 03/11/21.
//

import UIKit

class MatchVC: UIViewController {
    
    let imageView: UIImageView = .photoImageView(named: "pessoa-1")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.imageView)
        self.imageView.preencherSuperview()
    }
    
}
