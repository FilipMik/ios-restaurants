//
//  RestaurantTableTableViewController.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var locationService: LocationService = LocationService()
    weak var activityIndicatorView: UIActivityIndicatorView!
    
    var restaurants = [RestaurantElement]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        tableView.backgroundView = indicator
        self.activityIndicatorView = indicator
        
        indicator.startAnimating()
        
        if let location = locationService.getCoordinates() {
            getRestaurants(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        } else {
            getRestaurants(latitude: 49.196937, longitude: 16.608398)
        }
    }
    
    private func getRestaurants(latitude: Double, longitude: Double) {
        let client = RestaurantClient()
        
        client.getRestaurantsByLocation(lat: latitude, lon: longitude) { (result) in
            switch result {
            case .success(let restaurantsResult):
                guard let restaurants = restaurantsResult?.restaurants else { return }
                self.restaurants = restaurants
                self.activityIndicatorView.stopAnimating()
            case .failure(let error):
                self.activityIndicatorView.stopAnimating()
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
        
        let restaurant = restaurants[indexPath.row]
        var distanceString = ""
        
        if let location = locationService.getCoordinates() {
            
            let distanceMeters = locationService.getDistanceBetweenLocations(
                loc1Long: location.coordinate.longitude,
                loc1Lat: location.coordinate.latitude,
                loc2Long: restaurant.restaurant.location.longitude!,
                loc2Lat: restaurant.restaurant.location.latitude!)
            
            if (distanceMeters > 1000.0) {
                distanceString = (distanceMeters / 1000.0).fixedFraction(digits: 1) + " km"
            } else {
                distanceString = distanceMeters.fixedFraction(digits: 1) + " m"
            }
            
        } else {
            distanceString = "-m"
        }
        
        cell.initCell(with: restaurant, with: distanceString)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "DetailStoryboardViewController") as! DetailsFoodViewController
        
        dvc.restaurantElement = restaurants[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension FloatingPoint {
    func fixedFraction(digits: Int) -> String {
        return String(format: "%.\(digits)f", self as! CVarArg)
    }
}
