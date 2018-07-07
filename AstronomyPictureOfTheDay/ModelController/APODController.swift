//
//  APODController.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//
import UIKit
class APODController {
    
    static let shared = APODController()
    
    var baseURL = URL(string: "https://api.nasa.gov/planetary/apod?")
    
    var APODS = [APOD]()
    
    func fetchAPODS(_ date: Date, completion: @escaping(APOD?) -> Void) {
        let queries = [
            "api_key": "TK7xNPR7Vxivh47QCyZjwKUsQMOxL3eqp1dgfWTO",
            "date": "\(date.convertToString())"
        ]
        guard let url = baseURL?.withQueries(queries) else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("error accessing url \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let apod = try jsonDecoder.decode(APOD.self, from: data)
                    completion(apod)
                } catch {
                    print("error decoding data \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            }
        }
        dataTask.resume()
    }
    
    func fetchImage(forAPOD apod: APOD, completion: @escaping(UIImage?) ->Void) {
        guard let url = apod.url else {completion(nil); return}
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error accessing url \(error.localizedDescription)")
                completion(nil)
                return
            }
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
        }
        dataTask.resume()
    }
}

