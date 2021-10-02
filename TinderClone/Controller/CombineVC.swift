//
//  CombineVC.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 26/09/21.
//

import UIKit

enum Action {
    case like
    case deslike
}

class CombineVC: UIViewController {
    
    var profileButton: UIButton = .iconHeader(named: "icone-perfil")
    var chatButton: UIButton = .iconHeader(named: "icone-chat")
    var logoButton: UIButton = .iconHeader(named: "icone-logo")
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        
        self.addHeader()
        self.addFooter()
        self.searchUsers()
    }
    
    func searchUsers() {
        self.users = UserService.shared.searchUsers()
        self.addCards()
    }
}

extension CombineVC {
    func addHeader() {
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [profileButton, chatButton, logoButton])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.preencher(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: top, left: 16, bottom: 0, right: 16)
        )
    }
    
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
    
    func removeCard(card: UIView) {
        card.removeFromSuperview()
        
        self.users = self.users.filter({ (user) -> Bool in
            return user.id != card.tag
        })
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
                
                if card.center.x > self.view.bounds.width + 50 {
                    self.animateCard(rotationAngle: rotateAngle, action: .like)
                    return
                }
                
                if card.center.x < -50 {
                    self.animateCard(rotationAngle: rotateAngle, action: .deslike)
                    return
                }
                
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = self.view.center
                    card.transform = .identity
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                })
            }
        }
    }
    
    func animateCard(rotationAngle: CGFloat, action: Action) {
        if let user = self.users.first {
            for view in self.view.subviews {
                if view.tag == user.id {
                    if let card = view as? CombineCardView {
                        
                        let center: CGPoint
                        
                        switch action {
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                        }
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                        }, completion: { (_) in
                            self.removeCard(card: card)
                        })
                    }
                }
            }
        }
    }
}
