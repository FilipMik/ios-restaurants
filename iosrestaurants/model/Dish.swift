//
//  Dish.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 07/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct Dish: Decodable {
    let dishID, name, price: String?
    
    enum CodingKeys: String, CodingKey {
        case dishID = "dish_id"
        case name, price
    }
}
