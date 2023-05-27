//
//  LocalState.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 27.05.2023.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnboard
    }
    
    public static var hasOnboard: Bool{
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboard.rawValue)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboard.rawValue)
            // sychronizing utulity is no longer requred because of changes above ios
//            UserDefaults.standard.synchronize()
        }
    }
}
