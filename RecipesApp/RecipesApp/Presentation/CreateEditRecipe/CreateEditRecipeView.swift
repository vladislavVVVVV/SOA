//
//  CreateEditRecipeView.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import UIKit

class CreateEditRecipeViewController: UIViewController {
    let createEditRecipeViewModel: CreateEditRecipeViewModel
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Наименование"
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите имя"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let ingridientsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let chooseIngridientsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Choose ingridients", for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch createEditRecipeViewModel.state {
        case .create:
            setupLargeNavigationBarWith(title: "Create new recipe")
        case .edit(let recipe):
            setupLargeNavigationBarWith(title: "Edit \(recipe.name ?? "recipe")")
            nameTextField.text = recipe.name
            var ingridients = String()
            recipe.ingredients?.forEach({ (ingridient) in
                ingridients += ((ingridient.name ?? "") + ", ")
            })
            if ingridients != "" {
                ingridients.removeLast(2)
            }
            ingridientsLabel.text = ingridients
        }
        saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        chooseIngridientsButton.addTarget(self, action: #selector(chooseRecipes), for: .touchUpInside)
        addSubviews()
        setupConstraints()
    }

    // The object View Model which comes to the init.
    required init(_ createEditRecipeViewModel: CreateEditRecipeViewModel) {
        self.createEditRecipeViewModel = createEditRecipeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(saveButton)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(ingridientsLabel)
        stackView.addArrangedSubview(chooseIngridientsButton)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.trailing.leading.equalToSuperview().offset(10)
            $0.height.equalTo(150)
        }
        saveButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).inset(-30)
            $0.width.equalTo(100)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        nameTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
    }
    
    @objc private func saveItem() {
//       guard nameTextField.text != "" && fatTextField.text != "" && carbTextField.text != "" && proteinTextField.text != "" else {
//            showDefaultErrorAlert()
//            return
//        }
    }
    
    @objc private func chooseRecipes() {
//        switch createEditRecipeViewModel.state {
//        case .edit(let recipe):
//            let navigationController = UINavigationController(rootViewController: ChooseRecipeViewController(appContainer.prepareChooseRecipesViewModel(menu: menu)))
//            present(navigationController, animated: true, completion: nil)
//        default:
//            let navigationController = UINavigationController(rootViewController: ChooseRecipeViewController(appContainer.prepareChooseRecipesViewModel()))
//            present(navigationController, animated: true, completion: nil)
//        }
        
    }
}
