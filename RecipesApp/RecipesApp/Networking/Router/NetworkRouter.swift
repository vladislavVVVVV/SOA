//
//  NetworkRouter.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import Foundation
import Alamofire

struct Server {
    struct Production {
        static let baseURL = "https://api.nytimes.com/svc/topstories/v2/"
    }
    
    struct PathComponent {
        static let json = ".json"
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json;charset=UTF-8"
}

protocol NetworkRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}


extension NetworkRouter {
    
    func asURLRequest() throws -> URLRequest {
        let url = try Server.Production.baseURL.asURL()
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        var queryItems: [URLQueryItem] = []
        let queryItem = URLQueryItem(name: "api-key", value: "CJQwe50hGvB8SbFRuiAFKvfYbkye5zjt")
        queryItems.append(queryItem)
        urlComponents?.queryItems = queryItems
        
        guard let urlFromComponents = urlComponents?.url else {
            throw AFError.parameterEncodingFailed(reason: .missingURL)
        }
        
        var urlRequest = URLRequest(url: urlFromComponents.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
