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
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession.shared
    }
    
    func getRestaurants(from searchEndpoint: SearchEndpoint,
                        completition: @escaping RestaurantCompletition) {
   
        fetchData(with: searchEndpoint.request, decode: { json -> RestaurantResponse? in
            guard let restaurantResponse = json as? RestaurantResponse else { return nil }
            return restaurantResponse
        }, completition: completition)
    }
    
    func getRestaurantDailyMenu(from dailyMenuEndpoint: DailyMenuEnpoint,
                                completition: @escaping DailyMenuCompletition) {
        fetchData(with: dailyMenuEndpoint.request, decode: { json -> DailyMenu? in
            guard let dailyMenu = json as? DailyMenu else { return nil }
            return dailyMenu
        }, completition: completition)
    }
}
