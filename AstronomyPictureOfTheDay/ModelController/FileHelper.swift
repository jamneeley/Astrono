//
//  FileHelper.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

class FileHelper {
    
    static var fileManager = FileManager.default
    
    static var apodDirectory: URL {
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let apodDirectory = documentDirectory.appendingPathComponent("apod", isDirectory: true)
        if fileManager.fileExists(atPath: apodDirectory.path) == false {
            do {
                try fileManager.createDirectory(at: apodDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error - failed to create firectory \(error.localizedDescription)")
            }
        }
        return apodDirectory
    }
    
    
    static func fileURL(for date: String) -> URL? {
        let url = apodDirectory.appendingPathExtension("\(date)")
        return url
    }
    
    static func store(_ image: UIImage, apod: APOD) {
        let title = apod.title ?? ""
        let explanation = apod.explanation ?? ""
        let mediaType = apod.media_type ?? "image"
        let copyright = apod.copyright ?? ""
        guard let date = apod.date,
        let fileURL = self.fileURL(for: date)
            else {return}
        guard fileManager.fileExists(atPath: fileURL.path) == false,
            let imageData = UIImageJPEGRepresentation(image, 1)
            else {return}
        let astrononomyObject = AstronomyObject(imageData: imageData, title: title, explanation: explanation, mediaType: mediaType, copyright: copyright, date: date)
        
        saveToPersistanceStore(object: astrononomyObject)
    }
    
    static func saveToPersistanceStore(object: AstronomyObject) {
        let jsonEncoder = JSONEncoder()
        do {
            let encodeData = try jsonEncoder.encode(object)
            guard let fileURL = fileURL(for: object.date) else {return}
            try encodeData.write(to: fileURL)
        } catch let error {
            print("error saving \(error.localizedDescription)")
        }
    }
    
    static func retrieve(objectForDate date: String) -> AstronomyObject? {
        guard let fileURL = self.fileURL(for: date) else {return nil}
        let jsonDecoder = JSONDecoder()
        do{
            let encodedData = try Data(contentsOf: fileURL)
            let astronomyObject =  try jsonDecoder.decode(AstronomyObject.self, from: encodedData)
            return astronomyObject
        } catch let error {
            print("error loading \(error.localizedDescription)")
        }
    
        print("Couldn't retrieve data for \(date) at \(fileURL.path)")
        return nil
    }
    
    //Used for testing
    static func deleteAPODex() {
        do {
            try fileManager.removeItem(at: apodDirectory)
            
        }catch {
            print("Failed to remove APODex \(error)")
        }
    }
}




