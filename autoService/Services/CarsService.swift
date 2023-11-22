//
//  CarsServise.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

final class CarsService {
    //MARK: - Private properties
    private var networkClient: NetworkService
    
    init(networkClient: NetworkService) {
        self.networkClient = networkClient
    }
    //MARK: - Public methods
    func loadCars(query: String, completion: @escaping(Result<[String], Error>)->Void) {
        networkClient.request(path: Requests.common.path, method: "POST", body: CarsListRequestBody(query: query)) { (result: Result<CarsSuggestions, Error>) in
            switch result {
            case .success(let data) :
                let brands = data.suggestions.map({ $0.data.nameRu
                })
                completion(.success(brands))
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

