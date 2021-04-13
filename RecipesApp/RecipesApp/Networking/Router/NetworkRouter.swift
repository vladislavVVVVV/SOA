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
        static let baseURL = "http://localhost:5000/"
    }
    
    struct PathComponent {
        static let api = "api"
        
        static let auth = "AuthManagement"
        static let register = "Register"
        static let login = "Login"
        
        static let ingredient = "Ingredient"
        static let menues = "Menues"
        static let recipes = "Recipes"
    }
}

enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case authorizationToken = "Authorization"
}

// Enum of header values.
enum ContentType: String {
    case json = "application/json;charset=UTF-8"
    case formUrlencoded = "application/x-www-form-urlencoded"
}

// Enum of authorization details.
enum AuthorizationDetails: String {
    case tokenType = "Bearer"
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
