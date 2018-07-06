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
    
    static func fileURL(for apod: APOD) -> URL {
        let fileName = "\(apod.date)"
        let url = apodDirectory.appendingPathExtension(fileName)
        return url
    }
    
    static func store(_ image: UIImage, apod: APOD) {
        let fileURL = self.fileURL(for: apod)
        guard fileManager.fileExists(atPath: fileURL.path) == false,
            let data = UIImageJPEGRepresentation(image, 1)
            else {return}
        do {
            try data.write(to: fileURL)
        } catch {
            print("error saving to url \(fileURL.path)")
        }
    }
    
    static func retrieve(ImageFor apod: APOD) -> UIImage? {
        let fileURL = self.fileURL(for: apod)
        guard let data = fileManager.contents(atPath: fileURL.path) else {
            print("Couldn't retriece data for \(apod.date) as \(fileURL.path)")
            return nil
        }
        let image = UIImage(data: data)
        return image
    }
    
    static func deleteAPODex() {
        do {
            try fileManager.removeItem(at: apodDirectory)
            
        }catch {
            print("Failed to remove APODex \(error)")
        }
    }
}
