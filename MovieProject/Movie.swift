//
//  Moive.swift
//  MovieProject
//
//  Created by 염성필 on 2023/07/28.
//

import UIKit

struct Movie: Codable {
    var title: String
    var releaseDate: String
    var runtime: Int
    var overview: String
    var rate: Double
}
