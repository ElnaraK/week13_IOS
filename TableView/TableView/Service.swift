//
//  Service.swift
//  TableView
//
//  Created by Elnara  on 4/9/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()

    func downloadModels(completion: @escaping (DownloadResponse) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DownloadResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    func downloadMore(_ url: String, completion: @escaping (DownloadResponse) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(DownloadResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    class DownloadResponse: Codable {
        var info: Info
        var models: [Model]
        
        enum CodingKeys: String, CodingKey {
            case info = "info"
            case models = "results"
        }
    }
}
