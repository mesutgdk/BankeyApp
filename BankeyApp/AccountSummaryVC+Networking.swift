//
//  AccountSummaryVC+Networking.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 8.06.2023.
//

import Foundation
import UIKit



struct Account: Codable {
    let id: String
    let type: AccountType // make AccountType "Codable"
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account {
        return Account(id: "1", type: .Banking, name: "Account Name", amount: 0.0, createdDateTime: Date())
    }
}

extension AccountSummaryViewController{
    func fetchAccounts(forUserId userID: String, comletion: @escaping (Result<[Account],NetworkError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")!
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                
                guard let data = data, error == nil else {
                    comletion(.failure(.serverError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode([Account].self, from: data)
                    comletion(.success(accounts))
                } catch {
                    comletion(.failure(.decodingError))
                }
            }
        }.resume()
        
        
    }
    
    
}

