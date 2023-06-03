//
//  LoginView.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 20.05.2023.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let stackView = UIStackView()
    
    let userNameTextField = UITextField()
    let passwordtextField = UITextField()
    
    let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LoginView {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "UserName"
        userNameTextField.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        passwordtextField.translatesAutoresizingMaskIntoConstraints = false
        passwordtextField.placeholder = "Password"
        passwordtextField.isSecureTextEntry = true
        passwordtextField.delegate = self
        passwordtextField.enablePasswordToggle()
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    func layout() {
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordtextField)
        
        addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
        passwordtextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            return true
       
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
