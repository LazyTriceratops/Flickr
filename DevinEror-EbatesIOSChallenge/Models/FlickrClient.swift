//
//  FlickrClient.swift
//  DevinEror-EbatesIOSChallenge
//
//  Created by Devin Eror on 10/12/18.
//  Copyright © 2018 Devin Eror. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailed
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailed
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .jsonConversionFailed: return "JSON Conversion Failure"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailed: return "JSON Parsing Failure"
        }
    }
}



class FlickrClient {
    
    typealias TaskCompletionHandler = (FlickrData?, APIError?) -> Void
    
    class func getRecent(completionHandler completion: @escaping TaskCompletionHandler) {
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=fee10de350d1f31d5fec0eaf330d2dba&format=json&nojsoncallback=true")!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { completion(nil, .requestFailed) }
            guard let data = data else { completion(nil, .invalidData); return }
            
            DispatchQueue.main.async {
                do {
                    let flickrData = try JSONDecoder().decode(FlickrData.self, from: data)
                    completion(flickrData, nil)
                } catch {
                    completion(nil, .jsonParsingFailed)
                }
            }
        }
        task.resume()
    }
}
