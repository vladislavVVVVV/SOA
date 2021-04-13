//
//  CreateEditIngridientViewModel.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation

protocol CreateEditIngridientDelegate: AnyObject {
    func update()
}

enum IngridientState: Equatable {
    case create
    case edit(ingridient: Ingridient)
}

final class CreateEditIngridientViewModel {
    let appClient: AppClientProtocol
    let state: IngridientState
    weak var delegate: CreateEditIngridientDelegate? = nil
    
    init(appClient: AppClientProtocol, state: IngridientState) {
        self.state = state
        self.appClient = appClient
    }
    
    func createEditIngridient(name: String, fats: Int, proteins: Int, carbohydrates: Int, success: @escaping() -> Void, failure: @escaping(NetworkRequestError) -> Void) {
        switch state {
        case .create:
            appClient.createIngridient(name: name, fats: fats, proteins: proteins, carbohydrates: carbohydrates).onSuccess { [weak self] () in
                guard let self = self else { return }
                success()
                self.delegate?.update()
            }.onFailure { (error) in
                failure(error)
            }
        case .edit(let ingridient):
            appClient.editIngridient(id: ingridient.ingredientId ?? 0, name: name, fats: fats, proteins: proteins, carbohydrates: carbohydrates).onSuccess { [weak self] () in
                guard let self = self else { return }
                success()
                self.delegate?.update()
            }.onFailure { (error) in
                failure(error)
            }
        }
    }
}
