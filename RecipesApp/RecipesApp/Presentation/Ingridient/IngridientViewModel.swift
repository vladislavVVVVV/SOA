//
//  IngridientViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

final class IngridientViewModel {
    var selectedIngridient: Ingridient
    let appClient: AppClientProtocol
    
    init(ingridient: Ingridient, appClient: AppClientProtocol) {
        self.selectedIngridient = ingridient
        self.appClient = appClient
    }

    func getIngridient(id: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getIngridient(id: id).onSuccess { [weak self] (ingridient) in
            guard let self = self else { return }
            self.selectedIngridient = ingridient
            success()
        }.onFailure { (error) in
            failure(error)
        }
    }
}
