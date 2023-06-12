//
//  ProfileManager.swift
//  BankeyApp
//
//  Created by Mesut Gedik on 12.06.2023.
//

/*
 - dependency injection için sahte bir fetch yapmamız lazım, bunu da protocol oluşturarak yaptıyoruz
 - AnyObject olmasının sebebi class implementation istememiz, yani referance based implementaiton, çünkü UIKit te çalışıyoruz
 */
import Foundation

protocol ProfileManageable: AnyObject {
    func fetchProfile(forUserId userID:String, completion: @escaping (Result<Profile,NetworkError>) -> Void)
}
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

class ProfileManager: ProfileManageable {
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
