//
//  AccountSummaryVC+Networking.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 8.06.2023.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

extension AccountSummaryViewController{
    func fetchProfile(forUserId userID:String, completion: @escaping (Result<Profile,NetworkError>) -> Void) {
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)")!
        URLSession.shared.dataTask(with: url) { data, responce, error in
            
            DispatchQueue.main.async { // put background thread into main thread
                guard let data = data, error == nil else{
                    completion(.failure(.serverError))
                    return
                }
                
                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                } catch {
                    completion(.failure(.decodingError))
                }
                
            }
            
        }.resume()
    }
    
}

struct Account: Codable {
    let id: String
    let type: AccountType // make AccountType "Codable"
    let name: String
    let amount: Decimal
    let createdDateTime: Date
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

