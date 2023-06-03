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
        
    let mainVC = MainViewController()
    
    let accountSummaryVC = AccountSummaryViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerVC.delegate = self
        
        
        displayLogin()
    
//        mainVC.selectedIndex = 1 // it is the opening VC, first VC is seen, u can choose
        
        return true
    }
    
    private func displayLogin(){
        setRootVC(loginViewController)
    }
    
    private func displayNextScreen(){
        if LocalState.hasOnboard {
            prepareMainView()
            setRootVC(mainVC)
        } else {
            setRootVC(onboardingContainerVC)
        }
    }
    
    private func prepareMainView(){
        mainVC.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}
extension AppDelegate: LoginViewControllerDelegate{
    func didLogin() {
        displayNextScreen()
    }
}

extension AppDelegate: OnboardingVCDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboard = true
        prepareMainView()
        setRootVC(mainVC)
    }
}
extension AppDelegate: LogoutDelegate {
    func didLogOut() {
        LocalState.hasOnboard = true
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

