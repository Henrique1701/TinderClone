//
//  UIImageView.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 26/09/21.
//

import UIKit

extension UIImageView {
    
    static func photoImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func iconCard(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.size(size: .init(width: 70, height: 70))
        return imageView
    }
}
