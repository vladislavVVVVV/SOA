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
    private let userManager: UserManager
    var menues = [Menu]()

    init(appClient: AppClientProtocol, userManager: UserManager) {
        self.appClient = appClient
        self.userManager = userManager
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
    
    func logout(complition: () -> Void) {
        userManager.logout()
        complition()
    }
}
