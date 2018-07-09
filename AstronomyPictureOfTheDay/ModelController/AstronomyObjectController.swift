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
    var objects = [AstronomyObject]()

    func create(newObjectWithapod apod: APOD, image: UIImage) {
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        let title = apod.title ?? ""
        let explanation = apod.explanation ?? ""
        let mediaType = apod.media_type ?? "image"
        let copyright = apod.copyright ?? ""
        let date = apod.date ?? ""
        let newObject = AstronomyObject(imageData: imageData, title: title, explanation: explanation, mediaType: mediaType, copyright: copyright, date: date)
        objects.append(newObject)
        saveToPersistanceStore()
    }
    
    func fileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullURL = documentsDirectory.appendingPathComponent("apods").appendingPathExtension("json")
        print(fullURL)
        return fullURL
    }
    
    func saveToPersistanceStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let encodeData = try jsonEncoder.encode(objects)
            try encodeData.write(to: fileURL())
        } catch let error {
            print("error saving \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistantStore() -> [AstronomyObject] {
        let jsonDecoder = JSONDecoder()
        do{
            let encodedData = try Data(contentsOf: fileURL())
            let decodedData =  try jsonDecoder.decode([AstronomyObject].self, from: encodedData)
            return decodedData
        } catch let error {
            print("error loading \(error.localizedDescription)")
        }
        return []
    }
    
    init() {
        objects = loadFromPersistantStore()
    }
    
}

