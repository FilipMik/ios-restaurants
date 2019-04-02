//
//  LocationViewController.swift
//  iosrestaurants
//
//  Created by Tatiana Kminiakova on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    var locationService: LocationService?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationView.didTapAllow = {
            print("tapped")
            //self?.locationService?.requestLocationAuthorization()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
