//
//  UserRating.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 06/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


struct UserRating: Decodable {
    let fakeReviewsCount: Int
    let ratingText: String?
    let ratingColor: String
    let ratingToolTip: String?
    //TODO I am not able to parse aggregate_rating, votes
    
    enum CodingKeys: String, CodingKey {
        case ratingColor = "rating_color"
        case ratingToolTip = "rating_tool_tip"
        case fakeReviewsCount = "has_fake_reviews"
        case ratingText = "rating_text"
    }
}
