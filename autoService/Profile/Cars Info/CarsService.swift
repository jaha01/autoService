//
//  CarsServise.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

final class CarsService {
    
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func loadCars(query: String, completion: @escaping(Result<[String], Error>)->Void) {
        // можно ли так делать??? с path
        networkClient.request(path: "/suggestions/api/4_1/rs/suggest/car_brand", method: "POST", query: query) { (result: Result<CarsSuggestions, Error>) in
            switch result {
            case .success(let data) :
                print("data = \(data)")
                //completion(.success(data))
                // map. -> convert to array
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

