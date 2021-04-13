//
//  IngridientsViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation
import BrightFutures

final class IngridientsViewModel {

    private let appClient: AppClientProtocol
    private let userManager: UserManager
    var ingridients = [Ingridient]()

    init(appClient: AppClientProtocol, userManager: UserManager) {
        self.appClient = appClient
        self.userManager = userManager
    }

    func getIngridients(success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getIngridients().onSuccess { [weak self] (ingridients) in
            guard let self = self else { return }
            self.ingridients = ingridients
            success()
        }
    }
    
    func deleteIngridient(id: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.deleteIngridient(id: id).onSuccess { () in
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
