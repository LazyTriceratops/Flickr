//
//  FlickrModel.swift
//  DevinEror-EbatesIOSChallenge
//
//  Created by Devin Eror on 10/12/18.
//  Copyright © 2018 Devin Eror. All rights reserved.
//

import Foundation
import UIKit

struct FlickrData: Decodable {
    struct data: Decodable {
        var photo: [FlickrImage]
    }
    
    var photos: data
}



struct FlickrImage: Decodable {
    var farm: Int
    var id: String
    var owner: String
    var secret: String
    var server: String
    var title: String
    
    var imgURLBase: String {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)"
    }
    var thumbURL: URL {
        return URL(string: self.imgURLBase + "_q.jpg")!
    }
    var fullURL: URL {
        return URL(string: self.imgURLBase + "_b.jpg")!
    }
    
    var thumbData: Data? {
        do {
            let data = try? Data(contentsOf: thumbURL)
            return data
        }
    }
    
    var fullImage: Data? {
        do {
            let data = try? Data(contentsOf: fullURL)
            return data
        }
    }
}
