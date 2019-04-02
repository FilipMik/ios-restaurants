//
//  BaseView.swift
//  iosrestaurants
//
//  Created by Tatiana Kminiakova on 2.4.19.
//  Copyright © 2019 pv239. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure() {
        
    }
}
