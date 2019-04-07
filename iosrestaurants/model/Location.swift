//
//  Location.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct Location: Decodable {
    let address: String
    let locality: String
    let city: String
    let cityID: Int
    let lat: String
    let long: String
    let zip: String
    let countryID: Int
    let localityVerbose: String
    
    enum CodingKeys: String, CodingKey {
        case address, locality, city
        case cityID = "city_id"
        case countryID = "country_id"
        case localityVerbose = "locality_verbose"
        case lat = "latitude"
        case long = "longitude"
        case zip = "zipcode"
    }
}

extension Location {
    var longitude: Double? {
        return Double(long)
    }
    
    var latitude: Double? {
        return Double(lat)
    }
    
    var zipcode: Double? {
        return Double(zip)
    }
}


