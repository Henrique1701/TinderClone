//
//  CombineVC.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 26/09/21.
//

import UIKit

class CombineVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        
        self.addCards()
    }
}

extension CombineVC {
    func addCards() {
        for item in 1...3 {
            let redView = UIView()
            redView.backgroundColor = item == 2 ? .blue : .red
            redView.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
            
            redView.center = view.center
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            
            redView.addGestureRecognizer(gesture)
            
            view.addSubview(redView)
        }
    }
}

extension CombineVC {
    
    @objc func handlerCard (_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                })
            }
        }
    }
}