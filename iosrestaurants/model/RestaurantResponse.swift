//
//  RestaurantResponse.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct RestaurantResponse: Decodable {
    let resultsFound: Int
    let rasultsStart: Int
    let resultsShown: Int
    let restaurants: [RestaurantElement]
    
    enum CodingKeys: String, CodingKey {
        case resultsFound = "results_found"
        case rasultsStart = "results_start"
        case resultsShown = "results_shown"
        case restaurants
    }
}
