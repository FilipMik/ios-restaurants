//
//  DailyMenu.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 07/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation

struct DailyMenu: Decodable {
    let dailyMenuID, name, startDate, endDate: String?
    let dishes: [DishElement]?
    
    enum CodingKeys: String, CodingKey {
        case dailyMenuID = "daily_menu_id"
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case dishes
    }
}

struct DishElement: Decodable {
    let dish: Dish?
    
    enum CodingKeys: String, CodingKey {
        case dish
    }
}
