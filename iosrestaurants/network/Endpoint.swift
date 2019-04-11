//
//  Endpoint.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


protocol Endpoint {
    var base: String { get }
    
    var path: String { get }
    
    var parameters: [URLQueryItem]? { get }
}

extension Endpoint {
    var apiKey: String {
        return "17731c01bd8940454eb1e0510043b320"
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = parameters
        return components
    }
    
    var request: URLRequest {
        print(urlComponents.url!)
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.addValue(apiKey, forHTTPHeaderField: "user-key")
        print(urlRequest)
        return urlRequest
    }
}
