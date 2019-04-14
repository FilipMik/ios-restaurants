//
//  RestaurantDetail.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct RestaurantElement: Decodable {
    let restaurant: RestaurantDetail
}

struct RestaurantDetail: Decodable {
    let id: String
    let name: String
    let cuisines: String
    let priceRange: Int
    let photosURL: String
    let featuredImage: String
    let averageCostForTwo: Int
    let location: Location
    let thumb: String
    let user_rating: UserRating?
    let menuURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, user_rating
        case cuisines
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case thumb
        case photosURL = "photos_url"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
    }
}
