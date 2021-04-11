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
    var ingridients = [Ingridient]()

    init(appClient: AppClientProtocol) {
        self.appClient = appClient
    }

    func getIngridients(success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        appClient.getIngridients().onSuccess { [weak self] (ingridients) in
            guard let self = self else { return }
            self.ingridients = ingridients
            success()
        }
    }
}
