//
//  TokenExpiredInterceptor.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import Foundation
import Alamofire

// This class does work with tokens on requests.
final class TokenExpiredInterceptor: RequestInterceptor {
    // Pass accsess token to the request if required.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest>) -> Void) {
        var adaptedRequest = urlRequest
        let connectToken = KeychainManager.shared.connectToken
        guard !connectToken.accessToken.isEmpty else {
            completion(.success(adaptedRequest))
            return
        }
        adaptedRequest.setValue("\(AuthorizationDetails.tokenType.rawValue) \(connectToken.accessToken)", forHTTPHeaderField: HTTPHeaderField.authorizationToken.rawValue)
        completion(.success(adaptedRequest))
    }
}
