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

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    private let signInButton: UIButton = {
        let signInButton = UIButton(type: .system)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8 // for indicator spacing
        signInButton.setTitle("Sign In", for: [])
//        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        return signInButton
    }()
    
    private let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        return errorMessageLabel
    }()
    private let appNameLabel: UILabel = {
        let appNameLabel = UILabel()
        
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.textAlignment = .center
        appNameLabel.adjustsFontForContentSizeCategory = true
        appNameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        appNameLabel.text = "Bankey"
        appNameLabel.alpha = 0
        return appNameLabel
    }()
    
    private let appDescribeLabel: UILabel = {
        let appDescribeLabel = UILabel()
        
        appDescribeLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescribeLabel.textAlignment = .center
        appDescribeLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        appDescribeLabel.adjustsFontForContentSizeCategory = true
        appDescribeLabel.numberOfLines = 0
        appDescribeLabel.text = "Your premium source for all things banking!"
        appDescribeLabel.alpha = 0
        return appDescribeLabel
    }()
    
    weak var delegate : LoginViewControllerDelegate?
    
    var username : String? {
        return loginView.userNameTextField.text
    }
    var password : String? {
        return loginView.passwordtextField.text
    }
    
    //animation
    lazy var leadingEdgeOnScreen: CGFloat = 16
    lazy var leadingEdgeOffScreen: CGFloat = -1000
    
    weak var appTitleLeadingAnchor : NSLayoutConstraint?
    weak var appDeskriptionLeadingAnchor : NSLayoutConstraint?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        
    }

}
extension LoginViewController{
    private func setup() {
        //first of all, turn off this, at start
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // everything u made, u must add it
        view.addSubview(appNameLabel)
        view.addSubview(appDescribeLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        createNextButtonAction()
    
    }
    
    private func layout() {

        //LoginView
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            view.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
//            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        
        // AppNameLabel
        NSLayoutConstraint.activate([
            appDescribeLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 3),
            appNameLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
            
        appTitleLeadingAnchor = appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        appTitleLeadingAnchor?.isActive = true
        
        // AppDescribeLabel
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescribeLabel.bottomAnchor, multiplier: 3),
//            appDescribeLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appDescribeLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        appDeskriptionLeadingAnchor = appDescribeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        appDeskriptionLeadingAnchor?.isActive = true
        
    }
}
// MARK: - Action
extension LoginViewController {
    // new method for using swift instead of using obcj func
    private func createNextButtonAction(){
        let action = UIAction{[weak self] _ in
            self?.signInTapped()
        }
        signInButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func signInTapped(){
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
        if username == "Username" && password == "password" {
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
        shakeButton()
    }
}

// MARK: - Animations - to animate labels
extension LoginViewController{
    
    private func animate(){
        let duration = 0.8
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.appTitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.appDeskriptionLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.appNameLabel.alpha = 1
            self.appDescribeLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.3)
        
    }
}
// MARK: - Animation - Shake button if wrong answer
extension LoginViewController{
    
    private func shakeButton(){
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 15, -10, 5, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.3
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
        
    }
}



