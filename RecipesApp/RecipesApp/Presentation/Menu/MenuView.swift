//
//  MenuView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

class MenuViewController: UIViewController {
    let menuViewModel: MenuViewModel
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: menuViewModel.selectedMenu.name ?? "Menu")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editItem))
        addSubviews()
        setupConstraints()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        descriptionLabel.text = "Ниже представлены рецепты данного меню"
    }

    // The object View Model which comes to the init.
    required init(_ menuViewModel: MenuViewModel) {
        self.menuViewModel = menuViewModel
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
        let viewModel = appContainer.prepareCreateEditMenuViewModel(state: .edit(menu: menuViewModel.selectedMenu))
        let viewController = CreateEditMenuViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuViewModel.selectedMenu.recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier()) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = menuViewModel.selectedMenu.recipes?[indexPath.row]
        return cell
    }
}

