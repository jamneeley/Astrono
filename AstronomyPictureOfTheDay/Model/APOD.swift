//
//  APOD.swift
//  AstronomyPictureOfTheDay
//
//  Created by James Neeley on 7/6/18.
//  Copyright © 2018 JamesNeeley. All rights reserved.
//

import UIKit

struct APOD: Decodable {
    
    let url: URL?
    let title: String?
    let explanation: String?
    let media_type: String?
    let copyright: String?
    let date: String
    
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

extension Date {
    func convertToString() -> String {
        let stringDate = String("\(self)")
        var newDateCharacters = [Character]()
        for character in stringDate {
            if character == " "{
                break
            } else {
                newDateCharacters.append(character)
            }
        }
        let convertedDate = String(newDateCharacters)
        return convertedDate
    }
}


