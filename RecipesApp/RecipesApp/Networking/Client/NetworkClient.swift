//
//  NetworkClient.swift
//  RecipesApp
//
//  Created by Mac on 4/6/21.
//

import Alamofire
import BrightFutures

enum NetworkRequestError: Error {
    case unknownError
    case internetUnreachable
}

protocol NetworkClientProtocol {
    func performRequest<T: Decodable>(route: NetworkRouter, decoder: JSONDecoder) -> Future<T, NetworkRequestError>
    func performRequest(route: NetworkRouter, decoder: JSONDecoder) -> Future<Void, NetworkRequestError>
}

class NetworkClient: NetworkClientProtocol {
    let tockenInterceptor = TokenExpiredInterceptor()
    func performRequest<T: Decodable>(route: NetworkRouter,
                                      decoder: JSONDecoder = JSONDecoder()) -> Future<T, NetworkRequestError> {
        return Future { complete in
            AF.request(route, interceptor: tockenInterceptor).validate().responseDecodable(decoder: decoder,
                                                           completionHandler: { (response: DataResponse<T>) in
                if let error = response.error as? URLError, error.code == .notConnectedToInternet {
                    complete(.failure(.internetUnreachable))
                    return
                }
                    
                switch response.result {
                case .success(let data):
                    complete(.success(data))
                case .failure:
                    complete(.failure(.unknownError))
                }
            })
        }
    }
    
    func performRequest(route: NetworkRouter,
                        decoder: JSONDecoder = JSONDecoder()) -> Future<Void, NetworkRequestError> {
        return Future { complete in
            AF.request(route, interceptor: tockenInterceptor).validate().response { response in
                if let error = response.error as? URLError, error.code == .notConnectedToInternet {
                    complete(.failure(.internetUnreachable))
                    return
                }
                guard let statusCode = response.response?.statusCode else {
                    return complete(.failure(.unknownError))
                }
                guard statusCode != 200 else {
                    complete(.success(Void()))
                    return
                }
                complete(.failure(.unknownError))
            }
        }
    }
}
