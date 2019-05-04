//
//  RestaurantClient.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


class RestaurantClient: BaseClient {
    let session: URLSession
    
    typealias RestaurantCompletition = (Result<RestaurantResponse?,APIError>) -> Void
    typealias DailyMenuCompletition = (Result<DailyResponse?,APIError>) -> Void
    
    init() {
        self.session = URLSession.shared
    }
    
    func getRestaurants(completition: @escaping RestaurantCompletition) {
        let request = SearchEndpoint.search.request
        
        fetchData(with: request, decode: { json -> RestaurantResponse? in
            guard let restaurantResponse = json as? RestaurantResponse else { return nil }
            return restaurantResponse
        }, completition: completition)
    }
    
    func getRestaurantDailyMenu(resId id: Int, completition: @escaping DailyMenuCompletition) {
        let request = DailyMenuEnpoint.restaurantMenu(resId: id).request
        
        fetchData(with: request, decode: { json -> DailyResponse? in
            guard let dailyMenu = json as? DailyResponse else { return nil }
            return dailyMenu
        }, completition: completition)
    }
    
    func getRestaurantsByLocation(lat: Double, lon: Double, completition: @escaping RestaurantCompletition) {
        let request = SearchEndpoint.searchByLocation(lat: lat, lon: lon).request
        
        fetchData(with: request, decode: { (json) -> RestaurantResponse? in
            guard let restaurantResponse = json as? RestaurantResponse else { return nil }
            return restaurantResponse
        }, completition: completition)
    }
}
