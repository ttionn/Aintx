//
//  URLEncording.swift
//  Aintx
//
//  Created by Tong Tian on 21/10/2017.
//  Copyright © 2017 Bizersoft. All rights reserved.
//

import Foundation

struct URLEncording {
    
    static func encord(urlString: String, method: HttpMethod, params: [String: Any]?) throws -> URL {
        if let url = composeURL(urlString: urlString, method: method, params: params) {
            return url
        } else {
            throw HttpError.invalidURL(urlString)
        }
    }
    
    private static func composeURL(urlString: String, method: HttpMethod, params: [String: Any]?) -> URL? {
        guard method == .get, let params = params else {
            return nil
        }
        var url = urlString
        url += queryString(with: params)
        return URL(string: url)
    }
    
    private static func queryString(with params: Dictionary<String, Any>) -> String {
        var queryString = "?"
        
        for (key, value) in params {
            queryString += "\(key)=\(value)&"
        }
        
        return queryString
    }
    
}
