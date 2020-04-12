//
//  Info.swift
//  TableView
//
//  Created by Elnara  on 4/10/20.
//  Copyright © 2020 Elnara . All rights reserved.
//

import Foundation

class Info: Codable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String
    
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case pages = "pages"
        case next = "next"
        case prev = "prev"
    }
}
