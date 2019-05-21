//
//  DetailsFoodViewController.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var detailsFoodView: DetailsFoodView?
    var restaurantElement: RestaurantElement?
    let client = RestaurantClient()
    var dishes: [DishElement]? = [DishElement]() {
        didSet {
            self.detailsFoodView?.dishTableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let restaurantElement = restaurantElement {
            detailsFoodView?.initDetail(with: restaurantElement)
        }
        
        fetchData()
        self.title = ""
        self.detailsFoodView?.dishTableView?.delegate = self
        self.detailsFoodView?.dishTableView?.dataSource = self
        self.detailsFoodView?.initTopRoundedTableView()
        
    }
    
    func fetchData() {
        self.detailsFoodView?.hideIndicator(hide: false)
        client.getRestaurantDailyMenu(resId: Int(restaurantElement?.restaurant.id ?? "0") ?? 0) { (result) in
            switch result {
            case .success(let dailyMenuResponse):
                guard let dailyMenuResponse = dailyMenuResponse else {
                    return
                }
                
                if let dailyMenu = dailyMenuResponse.dailyMenuElement?.first?.dailyMenu {
                    self.dishes = dailyMenu.dishes
                    self.detailsFoodView?.dishTableView?.reloadData()
                    self.detailsFoodView?.hideIndicator(hide: true)
                    self.detailsFoodView?.showAvailableDailyMenu()
                } else {
                    self.detailsFoodView?.hideIndicator(hide: true)
                    self.detailsFoodView?.showNotAvailableDailyMenu()
                }
                
            case .failure(let error):
                print(error)
                self.detailsFoodView?.hideIndicator(hide: true)
                self.detailsFoodView?.showNotAvailableDailyMenu()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle,reuseIdentifier: "dailyMenuCell")
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        if let dish = dishes?[indexPath.row].dish {
            cell.textLabel?.text = dish.name
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.preferredMaxLayoutWidth = 220
            cell.detailTextLabel?.text = dish.price
            cell.detailTextLabel?.preferredMaxLayoutWidth = 50
            if let price = dish.price {
                if price.isEmpty {
                    cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes?.count ?? 0
    }
}
