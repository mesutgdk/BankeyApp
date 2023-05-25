//
//  ViewController.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 19.05.2023.
//

import UIKit

protocol LogoutDelegate: AnyObject{
    func didLogOut()
}

protocol LoginViewControllerDelegate : AnyObject {
//    func didLogin(_ sender: LoginViewController) // pass data
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let appNameLabel = UILabel()
    let appDescribeLabel = UILabel()
    
    weak var delegate : LoginViewControllerDelegate?
    
    var username : String? {
        return loginView.userNameTextField.text
    }
    var password : String? {
        return loginView.passwordtextField.text
    }
    
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
        errorMessageLabel.isHidden = true
        
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.textAlignment = .center
        appNameLabel.adjustsFontForContentSizeCategory = true
        appNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        appNameLabel.text = "Bankey"

        
        appDescribeLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescribeLabel.textAlignment = .center
        appDescribeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        appDescribeLabel.adjustsFontForContentSizeCategory = true
        appDescribeLabel.numberOfLines = 0
        appDescribeLabel.text = "Your premium source for all things banking!"

    }
    
    private func layout() {
        view.addSubview(loginView) // everything u made, u must add it
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(appNameLabel)
        view.addSubview(appDescribeLabel)
        
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
        
        // AppDescribeLabel
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescribeLabel.bottomAnchor, multiplier: 3),
            appDescribeLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appDescribeLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // AppNameLAbel
        NSLayoutConstraint.activate([
            appDescribeLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 3),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            appNameLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
//            appNameLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
    
    
}
extension LoginViewController {
    @objc func signInTapped(){
        errorMessageLabel.isHidden = true
        login()
    }
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username / Password should never be nil")
            return
        }
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be a blank")
            return
        }
        if username == "Mesut" && password == "Hello" {
            signInButton.configuration?.showsActivityIndicator = true
//            present(OnboardingContainerVC(), animated: true)
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    //it is what errorMessageLabel gives, just call it
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}


