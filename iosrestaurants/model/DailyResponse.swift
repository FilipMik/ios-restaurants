//
//  DailyResponse.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 29/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

struct DailyResponse: Decodable {
    let dailyMenuElement: [DailyMenuElement]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case dailyMenuElement = "daily_menus"
        case status
    }
}

struct DailyMenuElement: Decodable {
    let dailyMenu: DailyMenu?
    
    enum CodingKeys: String, CodingKey {
        case dailyMenu = "daily_menu"
    }
}
