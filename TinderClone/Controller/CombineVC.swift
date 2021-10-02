//
//  CombineVC.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 26/09/21.
//

import UIKit

class CombineVC: UIViewController {
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        
        self.addFooter()
        self.searchUsers()
    }
    
    func searchUsers() {
        self.users = UserService.shared.searchUsers()
        self.addCards()
    }
}

extension CombineVC {
    func addFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView(), deslikeButton, superlikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 34, right: 16)
            )
    }
}

extension CombineVC {
    
    func addCards() {
        
        for user in users {
            let cardView = CombineCardView()
            cardView.frame = CGRect(
                x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7
            )
            
            cardView.center = view.center
            cardView.user = user
            cardView.tag = user.id
            
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            
            cardView.addGestureRecognizer(gesture)
            
            view.insertSubview(cardView, at: 0)
        }
    }
}

extension CombineVC {
    
    @objc func handlerCard (_ gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            let rotateAngle = point.x / view.bounds.width * 0.3
            
            if point.x > 0 {
                card.likeImageView.alpha = rotateAngle * 5
                card.deslikeImageView.alpha = 0
            } else {
                card.deslikeImageView.alpha = -rotateAngle * 5
                card.likeImageView.alpha = 0
            }
            
            card.transform = CGAffineTransform(rotationAngle: rotateAngle)
            
            if gesture.state == .ended {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                    card.transform = .identity
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                })
            }
        }
    }
}
