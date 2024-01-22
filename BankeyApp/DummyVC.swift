//
//  DummyVC.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 25.05.2023.

import UIKit

final class DummyVC: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    private let label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()
    private let logoutButton: UIButton = {
       let logoutButton = UIButton(type: .system)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("LogOut", for: [])
        logoutButton.configuration = .filled()
//        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
        return logoutButton
    }()
    
    weak var logoutDelegate : LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}
// MARK: - Setup&Layout

extension DummyVC{
    private func setup(){
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        
        view.addSubview(stackView)
        logoutButtonAction()
    }
    
    private func layout(){

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
extension DummyVC {
    private func logoutButtonAction(){
        let action = UIAction{[weak self] _ in
            self?.logoutTapped()
        }
        logoutButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func logoutTapped (){
        logoutDelegate?.didLogOut()
    }
}

