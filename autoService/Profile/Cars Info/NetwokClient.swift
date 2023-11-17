//
//  NetwokClient.swift
//  autoService
//
//  Created by Jahongir Anvarov on 15.11.2023.
//

import Foundation

class NetworkClient : NSObject {
    private var networkConfiguration = NetworkConfig() // init
    private let jsonDecoder = JSONDecoder()
    
    //Конфигурация
    lazy var  configuration: URLSessionConfiguration =  {
        let configuration =  URLSessionConfiguration.default
        return configuration
    }()

//    init(network: NetworkConfig) {
//        let url = network
//    }
   
    lazy var urlSession: URLSession? = {
        return URLSession.init(configuration: configuration)
    }()
    
    private var dataTask: URLSessionDataTask? = nil
    
    func request<T:Codable>(path: String, method: String? = nil, query: String? = nil, completion: @escaping(Result<T,Error>)->Void) {
         print("request - \(networkConfiguration.url)\(path)")
        guard let url = URL(string: "\(networkConfiguration.url)") else {
            completion(.failure(NetworkError.fetching("Wrong uri")))
            print("error")
            return
        }
        var urlRequest = URLRequest(url: url)
        let headers = networkConfiguration.headers()
        let json: [String: Any] = ["query": query as Any]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        for header in headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        if method != nil {
            urlRequest.httpMethod = method
        }
        urlRequest.httpBody = jsonData
        
        
        self.dataTask = urlSession?.dataTask(with: urlRequest, completionHandler: { [weak self] data, response, error in
            guard let self = self else {return}
            
            if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<400:
                    let json = String.init(data: data, encoding: .utf8)
                    print("json = \(json)")
                    self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let content = try self.jsonDecoder.decode(T.self, from: data)
                        completion(.success(content))
                    } catch {
                        print(error)
                    }
                    if let content = try? self.jsonDecoder.decode(T.self, from: data) {
                        completion(.success(content))
                    } else {
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
