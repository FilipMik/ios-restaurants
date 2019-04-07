//
//  DailyMenuEndpoint.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 07/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


enum DailyMenuEnpoint {
    case restaurantMenu(resId: Int)
}

extension DailyMenuEnpoint: Endpoint {
    var base: String {
        return "https://developers.zomato.com"
    }
    
    var path: String {
        switch self {
        case .restaurantMenu: return "/api/v2.1/dailymenu"
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .restaurantMenu(let resId): return [URLQueryItem(name: "res_id", value: String(resId))]
        }
    }
}
