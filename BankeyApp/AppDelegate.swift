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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
//        window?.rootViewController = LoginViewController ()
//        window?.rootViewController = OnboardingContainerVC ()
//        window?.rootViewController = OnboardingVC(heroImageName: "delorean", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1990s")
        window?.rootViewController = onboardingContainerVC
//        window?.rootViewController = loginViewController

        return true
    }
}
extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
     print("foo - Did login")
    }
}

extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        print("foo - onboarding is done")
    }
}
