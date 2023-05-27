//
//  AppDelegate.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 19.05.2023.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
        
    let loginViewController = LoginViewController()
    
    let onboardingContainerVC = OnboardingContainerVC ()
    
    let dummyVC = DummyVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
        dummyVC.logoutDelegate = self
        
        window?.rootViewController = loginViewController
//        window?.rootViewController = MainViewController()


        return true
    }
}
extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
//     print("foo - Did login")
//        window?.rootViewController = onboardingContainerVC
        if LocalState.hasOnboard {
            setRootVC(onboardingContainerVC)
        } else {
            setRootVC(onboardingContainerVC)
        }
    }
}

extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        setRootVC(dummyVC)
        LocalState.hasOnboard = true
    }
}
extension AppDelegate: LogoutDelegate {
    func didLogOut() {
        setRootVC(loginViewController)
    }
}

extension AppDelegate {
    func setRootVC(_ vc:UIViewController, animated: Bool = true){
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: nil)
        
    }
}

