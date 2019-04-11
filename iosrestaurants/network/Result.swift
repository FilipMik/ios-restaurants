//
//  Result.swift
//  iosrestaurants
//
//  Created by Peter Žiška on 10/04/2019.
//  Copyright © 2019 pv239. All rights reserved.
//

import Foundation


enum Result<Value, Error> {
    case success(Value)
    case failure(Error)
}
