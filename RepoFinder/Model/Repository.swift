//
//  Repository.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 06/01/2022.
//

import Foundation
import UIKit

struct Repository: Codable {
    let name: String
}

struct MoreInfo: Codable {
    let name:String
    let moreInfoDescription: String?
    let contributorsURL: String
    let stargazersCount: Int
    let language: String?
    let forksCount: Int
    let license: License?
    let topics: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case moreInfoDescription = "description"
        case contributorsURL = "contributors_url"
        case stargazersCount = "stargazers_count"
        case language
        case forksCount = "forks_count"
        case license, topics
    }
}

struct License: Codable {
    let key: String
    let name: String
}

struct ContributorElement: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

typealias Contributor = [ContributorElement]

class RepositoriesHelper {
    static let shared = RepositoriesHelper()
    var repositories: [Repository] = []
    
    func getContributorData(gitHubName: String, repoName: String, completion: @escaping(Contributor?) -> ()){
        if let url = URL(string: "https://api.github.com/repos/\(gitHubName)/\(repoName)/contributors"){
            URLSession.shared.dataTask(with: url) { data, responde, error in
                if let data = data {
                    do {
                        let contr = try JSONDecoder().decode(Contributor.self, from: data)
                        completion(contr)
                    } catch let error {
                        print(error)
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
    
    func getMoreInfo(gitHubName: String, repoName: String, completion: @escaping(MoreInfo?) -> ()) {
        
        
        if let url = URL(string: "https://api.github.com/repos/\(gitHubName)/\(repoName)"){
            URLSession.shared.dataTask(with: url) { data, responde, error in
                if let data = data {
                    do {
                        let moreInfo = try JSONDecoder().decode(MoreInfo.self, from: data)
                        completion(moreInfo)
                    } catch let error {
                        print(error)
                        let moreInfo = MoreInfo(name: "", moreInfoDescription: "", contributorsURL: "", stargazersCount: 0, language: "", forksCount: 0, license: License(key: "", name: ""), topics: [])
                        completion(moreInfo)
                    }
                }
            }.resume()
        }
    }
    
    
    func getRepositories(gitUser: String, page: Int, completed: @escaping ([Repository]) ->Void ) {
        //
        if let url = URL(string: "https://api.github.com/users/" + gitUser + "/repos?per_page=100&page=\(page)") {
            URLSession.shared.dataTask(with: url) { data, responde, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode([Repository].self, from: data)
                        if result.count < 100 {
                            completed(result)
                        } else {
                            self.repositories += result
                            self.getRepositories(gitUser: gitUser, page: page + 1) { result in
                                completed(result)
                            }
                        }
                        
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL, completed: @escaping (UIImage) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            
            DispatchQueue.main.async() {
                if let image = UIImage(data: data) {
                    completed(image)
                } else {
                    completed(UIImage(systemName: "person.fill")!)
                }
            }
        }
    }
}

