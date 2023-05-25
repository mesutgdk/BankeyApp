//
//  OnboardingContainerVC.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 23.05.2023.
//

import UIKit

protocol OnboardingVCDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerVC: UIViewController {

    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    weak var delegate: OnboardingVCDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        // it is a test path to see UIPageVC
//        let page1 = ViewController1()
//        let page2 = ViewController2()
//        let page3 = ViewController3()
        
        let page1 = OnboardingVC(heroImageName: "car", titleText: "Bankey is faster, easier to use, and has brand new look and feel that will make you feel like you are back in 1990s.")
        let page2 = OnboardingVC(heroImageName: "world", titleText: "Move your money around the world quickly and securely.")
        let page3 = OnboardingVC(heroImageName: "thumbs", titleText: "Learn more at 'www.bankey.com'.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup(){
        view.backgroundColor = .systemPurple
        
        // It is how to add child VC to ParentVC, 3 steps
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Protocol-Delegate Pattern
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    private func style() {
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
        
        view.addSubview(closeButton)
    }
    private func layout(){
        
        //closeButton
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
    }
    
   
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerVC: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}
// MARK: -Actions
extension OnboardingContainerVC{
    
    @objc func closeTapped(_ sender: UIButton){
        //To Do
        delegate?.didFinishOnboarding()
    }
}
//// MARK: - ViewControllers
//class ViewController1: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemRed
//    }
//}
//
//class ViewController2: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemGreen
//    }
//}
//
//class ViewController3: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBlue
//    }
//}
