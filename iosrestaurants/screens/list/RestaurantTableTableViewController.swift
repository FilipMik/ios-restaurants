//
//  RestaurantTableTableViewController.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var isNextBatchLoading: Bool = false
    var isDataLoading: Bool = false
    var locationService: LocationService = LocationService()
    
    var restaurants = [RestaurantElement]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loading cell
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        
        loadData()
    }
    
    private func getRestaurants(latitude: Double, longitude: Double) {
        
        tableView.reloadSections(IndexSet(integer: 1), with: .none)
        
        let client = RestaurantClient()
        
        client.getRestaurantsByLocation(lat: latitude, lon: longitude, start: restaurants.count) { (result) in
            switch result {
            case .success(let restaurantsResult):
                guard let restaurants = restaurantsResult?.restaurants else { return }
                //self.activityIndicatorView.stopAnimating()
                self.restaurants.append(contentsOf: restaurants)
                
                self.isDataLoading = false
                self.isNextBatchLoading = false
            case .failure(let error):
                //self.activityIndicatorView.stopAnimating()
                
                self.isDataLoading = false
                self.isNextBatchLoading = false
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return restaurants.count
        } else if section == 1 && isNextBatchLoading {
            return 1
        }
        return 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "DetailStoryboardViewController") as! DetailsFoodViewController
        
        dvc.restaurantElement = restaurants[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if (offsetY > contentHeight - scrollView.frame.height) {
            if !self.isNextBatchLoading {
                self.isNextBatchLoading = true
                loadData()
            }
        }
    }
    
    private func loadData() {
        if !isDataLoading {
            self.isDataLoading = true
            if let location = locationService.getCoordinates() {
                getRestaurants(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            } else {
                getRestaurants(latitude: 49.196937, longitude: 16.608398)
            }
        }
    }
}

extension FloatingPoint {
    func fixedFraction(digits: Int) -> String {
        return String(format: "%.\(digits)f", self as! CVarArg)
    }
}
