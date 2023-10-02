//
//  UIITextField+ PasswordToogle.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 24.06.2023.
//

import Foundation
import UIKit

let favoriedToggleButton = UIButton(type: .custom)

extension UITextField{
    func enablePasswordToggle(){
        favoriedToggleButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        favoriedToggleButton.setImage(UIImage(systemName: "eye.circle.fill"), for: .selected)
        
        favoriedToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = favoriedToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_sender: Any){
        isSecureTextEntry.toggle()
        favoriedToggleButton.isSelected.toggle()
    }
}
