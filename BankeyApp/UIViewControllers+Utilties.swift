//
//  UIViewControllers+Utilties.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 27.05.2023.
//

import UIKit // i created additional parts, to set barimage and status easly

extension UIViewController {
    func setStatusBar(){
        
       let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground() // to hide Nav Bar Line also
        navBarAppearance.backgroundColor = appColor
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        
    }
    
    func setTabBarImage(imageName: String, title: String){
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName,withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        
    }
}
