//
//  CreateEditMenuView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

class CreateEditMenuViewController: UIViewController {
    let createEditMenuViewModel: CreateEditMenuViewModel
    
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
    
    private let recipesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let chooseRecipesButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Choose recipes", for: .normal)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch createEditMenuViewModel.state {
        case .create:
            setupLargeNavigationBarWith(title: "Create new menu")
        case .edit(let menu):
            setupLargeNavigationBarWith(title: "Edit \(menu.name ?? "menu")")
            nameTextField.text = menu.name
            var recipes = String()
            createEditMenuViewModel.selectedRecipes.forEach({ (recipe) in
                recipes += ((recipe.name ?? "") + ", ")
            })
            if recipes != "" {
                recipes.removeLast(2)
            }
            recipesLabel.text = recipes
        }
        saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        chooseRecipesButton.addTarget(self, action: #selector(chooseRecipes), for: .touchUpInside)
        addSubviews()
        setupConstraints()
    }

    // The object View Model which comes to the init.
    required init(_ createEditMenuViewModel: CreateEditMenuViewModel) {
        self.createEditMenuViewModel = createEditMenuViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(saveButton)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(recipesLabel)
        stackView.addArrangedSubview(chooseRecipesButton)
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
        createEditMenuViewModel.createEditMenu(name: nameTextField.text ?? "") { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        } failure: { [weak self] (error) in
            guard let self = self else { return }
            self.showDefaultErrorAlert()
        }
    }
    
    @objc private func chooseRecipes() {
        switch createEditMenuViewModel.state {
        case .edit(let menu):
            let viewModel = appContainer.prepareChooseRecipesViewModel(menu: menu)
            viewModel.delegate = self
            let navigationController = UINavigationController(rootViewController: ChooseRecipeViewController(viewModel))
            present(navigationController, animated: true, completion: nil)
        default:
            let viewModel = appContainer.prepareChooseRecipesViewModel()
            viewModel.delegate = self
            let navigationController = UINavigationController(rootViewController: ChooseRecipeViewController(viewModel))
            present(navigationController, animated: true, completion: nil)
        }
    }
}

extension CreateEditMenuViewController: ChooseRecipeViewDelegate {
    func didChoose(ingridients: [Recipe]) {
        createEditMenuViewModel.selectedRecipes = ingridients
        switch createEditMenuViewModel.state {
        case .create:
            setupLargeNavigationBarWith(title: "Create new menu")
            var recipes = String()
            createEditMenuViewModel.selectedRecipes.forEach({ (recipe) in
                recipes += ((recipe.name ?? "") + ", ")
            })
            if recipes != "" {
                recipes.removeLast(2)
            }
            recipesLabel.text = recipes
        case .edit(let menu):
            setupLargeNavigationBarWith(title: "Edit \(menu.name ?? "menu")")
            var recipes = String()
            createEditMenuViewModel.selectedRecipes.forEach({ (recipe) in
                recipes += ((recipe.name ?? "") + ", ")
            })
            if recipes != "" {
                recipes.removeLast(2)
            }
            recipesLabel.text = recipes
        }
    }
}
