//
//  CarsServise.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

class CarsService {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    public func loadCars<T: Codable>(completion: @escaping(Result<T, Error>)->Void) {
        networkClient.request() { (result: Result<T, Error>) in
            switch result {
            case .success(let data) :
                completion(.success(data))
            case .failure(let error):
                completion(.failure(NetworkError.fetching("Что-то пошло не так...")))
                if let customError = error as? NetworkError {
                    print(customError.localizedDescription)
                } else {
                    print(error)
                }
            }
        }
    }
}
