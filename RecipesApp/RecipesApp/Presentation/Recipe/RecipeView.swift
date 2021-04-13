//
//  RecipeView.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import UIKit

class RecipeViewController: UIViewController {
    let recipeViewModel: RecipeViewModel
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IngridientTableViewCell.self, forCellReuseIdentifier: IngridientTableViewCell.identifier())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: recipeViewModel.selectedRecipe.name ?? "Recipe")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editItem))
        addSubviews()
        setupConstraints()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        descriptionLabel.text = "Ниже представленны ингридиенты данного рецепта. С помощью их вы можеье приготоваить наш потрясающий рецепт"
    }

    // The object View Model which comes to the init.
    required init(_ recipeViewModel: RecipeViewModel) {
        self.recipeViewModel = recipeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().offset(12)
            $0.height.equalTo(150)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    @objc private func editItem() {
        let viewModel = appContainer.prepareCreateEditRecipeViewModel(state: .edit(recipe: recipeViewModel.selectedRecipe))
        let viewController = CreateEditRecipeViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeViewModel.selectedRecipe.ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientTableViewCell.identifier()) as? IngridientTableViewCell else {
            return UITableViewCell()
        }
        cell.ingridient = recipeViewModel.selectedRecipe.ingredients?[indexPath.row]
        return cell
    }
}
