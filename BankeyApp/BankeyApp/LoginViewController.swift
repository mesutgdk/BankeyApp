//
//  ViewController.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 19.05.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()

    }

}
extension LoginViewController{
    private func style() {
        //first of all, turn off this, at start
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error Failure"
//        errorMessageLabel.isHidden = true
    }
    
    private func layout() {
        view.addSubview(loginView) // everything u made, u must add it
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        //SignButtom
        NSLayoutConstraint.activate([
//    view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1) ya da
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2)
        ])
        
        // ErrorLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor)
        ])
    }
    
    
}
extension LoginViewController {
    
    @objc func signInTapped(){
        
    }
}


