//
//  AstronomyObjectController.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class AstronomyObjectController {
    
    static let shared = AstronomyObjectController()

    func create(newObjectWithTitle title: String, explanation: String, mediaType: String, copyright: String, date: String, image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        let _ = AstronomyObject(imageData: imageData, title: title, explanation: explanation, mediaType: mediaType, copyright: copyright, date: date)
        
        
    }
    
    
}
