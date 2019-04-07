//
//  SearchEndpoint.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


enum SearchEndpoint {
    case search
    case searchWithLimit(count: String)
}

extension SearchEndpoint: Endpoint {
    
    var base: String {
        return "https://developers.zomato.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/api/v2.1/search"
        case .searchWithLimit: return "/api/v2.1/search"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .search: return nil
        case .searchWithLimit(let count): return [URLQueryItem(name: "count", value: count)]
        }
    }
    
}
