//
//  DetailsFoodView.swift
//  iosrestaurants
//
//  Created by Filip Mik on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable class DetailsFoodView: BaseView {
    @IBOutlet weak var restaurantImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var tableViewBackgroundView: UIView?
    
    @IBOutlet weak var fifthStar: UIImageView?
    @IBOutlet weak var fourthStar: UIImageView?
    @IBOutlet weak var thirdStar: UIImageView?
    @IBOutlet weak var secondStar: UIImageView?
    @IBOutlet weak var firstStar: UIImageView?
    
    @IBOutlet weak var dishTableView: UITableView?
    @IBOutlet weak var notAvailableImageView: UIImageView?
    @IBOutlet weak var dateLabel: UILabel?
    
    @IBOutlet weak var mapView: MKMapView?
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    
    func initDetail(with restaurantElement: RestaurantElement) {
        initRestaurantLocation(location: restaurantElement.restaurant.location)
        initRestaurantInfo(restaurantElement: restaurantElement)
    }
    
    func initRestaurantInfo(restaurantElement: RestaurantElement) {
        locationLabel?.text = restaurantElement.restaurant.location.address
        nameLabel?.text = restaurantElement.restaurant.name
        dishTableView?.isHidden = true
        showCurrentDate()
        showRestaurantRating(rating: restaurantElement.restaurant.user_rating?.ratingText ?? "")
        
        if let imageUrl = URL(string: restaurantElement.restaurant.featuredImage) {
            restaurantImageView?.af_setImage(withURL: imageUrl)
        }
    }

    func initRestaurantLocation(location: Location) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: location.latitude ?? 0,
            longitude: location.longitude ?? 0)
        annotation.title = location.address
        
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, CLLocationDistance(exactly: 500)!, CLLocationDistance(exactly: 500)!)
        
        mapView?.isUserInteractionEnabled = false
        mapView?.setRegion((mapView?.regionThatFits(region))!, animated: false)
        mapView?.setCenter(annotation.coordinate, animated: true)
        mapView?.addAnnotation(annotation)
    }
    
    func initTopRoundedTableView() {
        if let tableViewBackgroundView = tableViewBackgroundView {
            tableViewBackgroundView.layer.masksToBounds = true
            tableViewBackgroundView.roundCorners(corners: [.topLeft,.topRight], radius: 25)
        }
    }
    
    func showCurrentDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateLabel?.text = formatter.string(from: date)
    }
    
    func showAvailableDailyMenu() {
        dishTableView?.isHidden = false
        notAvailableImageView?.isHidden = true
    }
    
    func showNotAvailableDailyMenu() {
        dishTableView?.isHidden = true
        notAvailableImageView?.isHidden = false
    }
    
    func showRestaurantRating(rating: String) {
        switch rating {
        case "Poor":
            fifthStar?.isHidden = true
            fourthStar?.isHidden = true
            thirdStar?.isHidden = true
            secondStar?.isHidden = true
        case "Good":
            fifthStar?.isHidden = true
            fourthStar?.isHidden = true
            thirdStar?.isHidden = true
        case "Average":
            fifthStar?.isHidden = true
            fourthStar?.isHidden = true
        case "Very Good":
            fifthStar?.isHidden = true
        case "Excellent":
            break
        default:
            fifthStar?.isHidden = true
            fourthStar?.isHidden = true
            thirdStar?.isHidden = true
            secondStar?.isHidden = true
            firstStar?.isHidden = true
        }
    }
    
    func hideIndicator(hide: Bool) {
        loadingIndicator?.isHidden = hide
    }
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let bounds = UIScreen.main.bounds
        let tableViewBounds = CGRect(x: 0, y: 0, width: bounds.width, height: self.bounds.height)
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: tableViewBounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = maskLayer
    }
}

