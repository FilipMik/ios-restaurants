//
//  AppDelegate.swift
//  iosrestaurants
//
//  Created by Filip Mik on 3.3.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            
            locationViewController?.locationService = locationService
            window.rootViewController = locationViewController
        default:
            let restaurantNavigation = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
        
            self.navigationController = restaurantNavigation
            window.rootViewController = restaurantNavigation
            locationService.getLocation()
        }
        window.makeKeyAndVisible()
        
        return true
    }
}

