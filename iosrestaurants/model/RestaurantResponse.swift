//
//  RestaurantResponse.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct RestaurantResponse: Decodable {
    let results_found: Int
    let results_start: Int
    let results_shown: Int
    let restaurants: [RestaurantElement]
    
    enum CodingKeys: String, CodingKey {
        case resultsFound = "results_found"
        case rasultsStart = "results_start"
        case resultsShown = "results_shown"
        case restaurants
    }
}
