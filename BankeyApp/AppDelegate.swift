//
//  AppDelegate.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 19.05.2023.
//

import UIKit

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
        dummyVC.delegate = self
        
        
        
//        window?.rootViewController = LoginViewController ()
//        window?.rootViewController = OnboardingContainerVC ()
//        window?.rootViewController = OnboardingVC(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1990s")
        window?.rootViewController = loginViewController
//        window?.rootViewController = onboardingContainerVC


        return true
    }
}
extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
//     print("foo - Did login")
//        window?.rootViewController = onboardingContainerVC
        setRootVC(onboardingContainerVC)
    }
}

extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        setRootVC(dummyVC)
        print("foo - onboarding is done")
    }
}
extension AppDelegate: DummyVCDelegate {
    func didLogOut() {
        setRootVC(loginViewController)
        print("foo - Logout operation done!")
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

