//
//  RestaurantTableTableViewController.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    private var locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init(nibName: "RestaurantTableViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var restaurants = [RestaurantElement]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        if let location = locationService.getCoordinates() {
            getRestaurants(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        } else {
            getRestaurants(latitude: 49.196937, longitude: 16.608398)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func getRestaurants(latitude: Double, longitude: Double) {
        let client = RestaurantClient()
        
        client.getRestaurantsByLocation(lat: latitude, lon: longitude) { (result) in
            switch result {
            case .success(let restaurantsResult):
                guard let restaurants = restaurantsResult?.restaurants else { return }
                self.restaurants = restaurants
            case .failure(let error):
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
        cell.initCell(with: restaurant)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyBoard.instantiateViewController(withIdentifier: "DetailStoryboardViewController") as! DetailsFoodViewController
        
        dvc.restaurantElement = restaurants[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
