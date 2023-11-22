//
//  NetwokClient.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

class NetworkService : NSObject {
    
    // MARK: - Private properties
    private var networkConfiguration = NetworkConfig()
    private var dataTask: URLSessionDataTask? = nil
    private let jsonDecoder = JSONDecoder()
    
    //Конфигурация
    lazy var  configuration: URLSessionConfiguration =  {
        let configuration =  URLSessionConfiguration.default
        return configuration
    }()
    
    lazy var urlSession: URLSession? = {
        return URLSession.init(configuration: configuration)
    }()
    
    // MARK: - Public methods
    func request<T:Codable>(path: String, method: String? = nil, body: Codable? = nil, completion: @escaping(Result<T,Error>)->Void) {
        guard let url = URL(string: "\(networkConfiguration.url)\(path)") else {
            completion(.failure(NetworkError.fetching("Wrong uri")))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        if let body = body, let jsonData = body.toJsonData() {
            urlRequest.httpBody = jsonData
        }
        let headers = networkConfiguration.headers()
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        if method != nil {
            urlRequest.httpMethod = method
        }
        
        self.dataTask = urlSession?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else {return}
            
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<400:
                    let json = String.init(data: data, encoding: .utf8)
                    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let content = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(content))
                    } catch {
                        completion(.failure(NetworkError.fetching("Failed parsing")))
                    }
                default:
                    completion(.failure(NetworkError.fetching("\(response.statusCode)")))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        })
        self.dataTask?.resume()
    }
}

