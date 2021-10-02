//
//  Loading.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 02/10/21.
//

import UIKit

class Loading: UIView {
    
    let loadView: UIView = {
        let load = UIView()
        load.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        load.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        load.layer.cornerRadius = 50
        load.layer.borderColor = UIColor.red.cgColor
        return load
    }()
    
    let profileImageView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "perfil")
        profile.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        profile.layer.cornerRadius = 100/2
        profile.layer.borderWidth = 5
        profile.layer.borderColor = UIColor.white.cgColor
        profile.clipsToBounds = true
        return profile
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(loadView)
        loadView.center = center
        
        self.addSubview(profileImageView)
        profileImageView.center = center
        
        self.animation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        UIView.animate(withDuration: 1.2, delay: 0, options: .curveEaseInOut, animations: {
            
            self.loadView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadView.layer.cornerRadius = 250/2
            self.loadView.center = self.center
            self.loadView.alpha = 0.3
            
        }, completion: { (_) in
            
            UIView.animate(withDuration: 1.2, delay: 0, options: .curveEaseInOut ,animations: {
                self.loadView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
                self.loadView.layer.cornerRadius = 50
                self.loadView.center = self.center
                self.loadView.alpha = 1
            }, completion: { (_) in
                self.animation()
            })
            
        })
    }
}
