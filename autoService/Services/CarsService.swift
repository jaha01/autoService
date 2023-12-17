//
//  CarsServise.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

protocol CarsServiceProtocol {
    func loadCars(query: String, completion: @escaping(Result<CarsSuggestions, Error>)->Void)
}

final class CarsService: CarsServiceProtocol {
    
    //MARK: - Private properties
    
    private var networkClient: NetworkService
    
    init(networkClient: NetworkService) {
        self.networkClient = networkClient
    }
    
    //MARK: - Public methods
    
    func loadCars(query: String, completion: @escaping(Result<CarsSuggestions, Error>)->Void) {
        networkClient.request(path: Requests.carsList.path, method: .post, body: CarsListRequestBody(query: query)) { (result: Result<CarsSuggestions, Error>) in
            switch result {
            case .success(let data) :
                completion(.success(data))
            case .failure(let error):
                if let customError = error as? NetworkError {
                    print(customError.localizedDescription)
                } else {
                    print(error)
                }
                completion(.failure(NetworkError.fetching("Что-то пошло не так...")))
            }
        }
    }
}

