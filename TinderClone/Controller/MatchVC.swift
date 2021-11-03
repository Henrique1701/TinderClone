//
//  MatchVC.swift
//  TinderClone
//
//  Created by José Henrique Fernandes Silva on 03/11/21.
//

import UIKit

class MatchVC: UIViewController {
    
    let photoImageView: UIImageView = .photoImageView(named: "pessoa-1")
    let likeImageView: UIImageView = .photoImageView(named: "icone-like")
    let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    
    let messageTextFild: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diga algo legal..."
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enviar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar para o Tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.photoImageView)
        self.photoImageView.preencherSuperview()
        
        self.messageLabel.text = "Ana curtiu você!"
        self.messageLabel.textAlignment = .center
        self.messageLabel.applyShadow()
        
        self.likeImageView.translatesAutoresizingMaskIntoConstraints = false
        self.likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.likeImageView.contentMode = .scaleAspectFit
        
        self.messageTextFild.addSubview(self.sendButton)
        sendButton.preencher(
            top: messageTextFild.topAnchor,
            leading: nil,
            trailing: messageTextFild.trailingAnchor,
            bottom: messageTextFild.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16)
        )
        
        self.backButton.titleLabel?.applyShadow()
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, messageLabel, messageTextFild, backButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        self.view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: self.view.leadingAnchor,
            trailing: self.view.trailingAnchor,
            bottom: self.view.bottomAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32)
        )
    }
    
}
