//
//  NetworkManager.swift
//  Phun App
//
//  Created by Kerry Ferguson on 3/12/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    private init() {}
    
    public func fetchMission(completion: @escaping (AFResult<[Mission]>) -> ()) {

            AF.request(url)
                .validate(statusCode: 200..<300)
                .response { (dataResponse) in
                    if let err = dataResponse.error {
                        completion(.failure(err))
                        return
                    }
                    guard let data = dataResponse.data else {
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let item = try decoder.decode([Mission].self, from: data)
                        
                        completion(.success(item))
                    } catch {
                        completion(.failure(error as! AFError))
                    }
                }
        }
}
