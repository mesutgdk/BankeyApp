//
//  UItextField+SecureToggle.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 3.06.2023.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField{
    func enablePasswordToggle(){
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    @objc func togglePasswordView(_sender: Any){
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
