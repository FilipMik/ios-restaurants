//
//  RestaurantTableViewCell.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initCell(with restaurant: RestaurantElement) {
        //restaurantNameLabel.text = restaurant.restaurant.name
        
        //if let unwrappedRating = restaurant.restaurant.user_rating {
        //    ratingLabel.text = unwrappedRating.aggregateRating
        //}
    }
}
