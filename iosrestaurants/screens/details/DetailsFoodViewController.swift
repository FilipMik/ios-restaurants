//
//  DetailsFoodViewController.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {
    
    @IBOutlet weak var detailsFoodView: DetailsFoodView!
    var restaurantElement: RestaurantElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = restaurantElement?.restaurant.name
        // Do any additional setup after loading the view.
    }
}
