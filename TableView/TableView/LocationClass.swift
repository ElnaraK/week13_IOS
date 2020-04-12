//
//  LocationClass.swift
//  TableView
//
//  Created by Elnara  on 4/9/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import Foundation

class LocationClass: Codable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case url = "url"
    }
}
