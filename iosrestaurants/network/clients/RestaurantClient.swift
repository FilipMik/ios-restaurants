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
    typealias DailyMenuCompletition = (Result<DailyMenu?,APIError>) -> Void
    
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
        
        fetchData(with: request, decode: { json -> DailyMenu? in
            guard let dailyMenu = json as? DailyMenu else { return nil }
            return dailyMenu
        }, completition: completition)
    }
    
    func getRestaurantsByLocation(lat: Double, lon: Double, start: Int, completition: @escaping RestaurantCompletition) {
        let request = SearchEndpoint.searchByLocation(lat: lat, lon: lon, start: start).request
        
        fetchData(with: request, decode: { (json) -> RestaurantResponse? in
            guard let restaurantResponse = json as? RestaurantResponse else { return nil }
            return restaurantResponse
        }, completition: completition)
    }
}
