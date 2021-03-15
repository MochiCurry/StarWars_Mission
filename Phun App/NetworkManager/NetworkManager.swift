//
//  NetworkManager.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case badData
    case badModel
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    public func fetchMission(completion: @escaping (Result<[Mission], NetworkError>) -> ()) {
    
        guard let apiURL = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        guard let data = try? Data(contentsOf: apiURL) else {
            completion(.failure(.badData))
            return
        }
        let decoder = JSONDecoder()
        guard let items = try? decoder.decode([Mission].self, from: data) else {
            completion(.failure(.badModel))
            return
        }
        completion(.success(items))
    }
}
