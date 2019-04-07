//
//  BaseClient.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


protocol BaseClient {
    var session: URLSession { get }
    
    func fetchData<T: Decodable>(with request: URLRequest,
                                 decode: @escaping (Decodable) -> T?,
                                 completition: @escaping (Result<T, APIError>) -> Void)
}

extension BaseClient {
    
    typealias JSONCompletitionHandler = (Decodable?, APIError?) -> Void
    
    private func decodeTask<T: Decodable>(with request: URLRequest,
                                          decodingType: T.Type,
                                          completitionHandler completition: @escaping JSONCompletitionHandler) -> URLSessionTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completition(nil, .requestFailed)
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: data)
                        completition(model, nil)
                    } catch {
                        completition(nil, .jsonParsingFailure)
                    }
                } else {
                    completition(nil, .invalidData)
                }
            } else {
                completition(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetchData<T: Decodable>(with request: URLRequest,
                                 decode: @escaping (Decodable) -> T?,
                                 completition: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodeTask(with: request, decodingType: T.self) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completition(Result.failure(error))
                    } else {
                        completition(Result.failure(.invalidData))
                    }
                    return
                }
                
                if let value = decode(json) {
                    completition(Result.success(value))
                } else {
                    completition(Result.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}

