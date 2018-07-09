//
//  AstronomyObject.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import Foundation

struct AstronomyObject: Codable {
    
    let imageData: Data
    let title: String
    let explanation: String
    let mediaType: String
    let copyright: String
    let date: String
}
