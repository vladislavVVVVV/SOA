//
//  MenuesViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation
import BrightFutures

final class MenuesViewModel {

    private let appClient: AppClientProtocol
    var menues = [Menu]()

    init(appClient: AppClientProtocol) {
        self.appClient = appClient
    }

    func getMenues(success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getMenues().onSuccess { [weak self] (menues) in
            guard let self = self else { return }
            self.menues = menues
            success()
        }
    }
    
    func deleteMenue(id: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.deleteMenue(with: id).onSuccess { () in
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
}
