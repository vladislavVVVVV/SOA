//
//  ChooseRecipeView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import SnapKit
import UIKit

final class ChooseRecipeViewController: UIViewController {
    let chooseRecipeViewModel: ChooseRecipeViewModel
    
    // All dimensions of the screen.
    private enum Dimensions {
        static let cellHeight: CGFloat = 68
    }
    
    // The activity indicator depending on the selected action on the screen.
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier())
        tableView.allowsMultipleSelection = true
        tableView.allowsSelection = true
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // The object View Model which comes to the init.
    required init(_ chooseRecipeViewModel: ChooseRecipeViewModel) {
        self.chooseRecipeViewModel = chooseRecipeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get object of AppTabBarController.
        setupLargeNavigationBarWith(title: "Choose recipes")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewItem))
        addSubviews()
        setupConstraints()
        setupRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        getRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Show menu options when the screen opens.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshBinItems), for: .valueChanged)
        refreshControl.tintColor = UIColor.Base.accentText
        tableView.refreshControl = refreshControl
    }
    
    @objc private func refreshBinItems(_ sender: AnyObject) {
        // Refresh items
        getRecipes()
        refreshControl.endRefreshing()
    }
    
    @objc private func addNewItem() {
//        let viewModel = appContainer.prepareCreateEditIngridient(state: .create)
//        let navigationViewController = UINavigationController(rootViewController: CreateEditIngridientViewController(viewModel))
//        present(navigationViewController, animated: true, completion: nil)
    }
    
    private func getRecipes() {
        chooseRecipeViewModel.getRecipes { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        } failure: { (error) in
            print(error.localizedDescription)
        }
    }

    private func setupDeleteAction(handler: (() -> Void)?) -> UIContextualAction {
        let deleteAction = UIContextualAction(style: .destructive, title: nil, handler: { _, _, _ in
            handler?()
        })
        deleteAction.backgroundColor = .red
        deleteAction.title = "Delete"
        return deleteAction
    }
    
    private func deleteRecipe(id: Int, indexPaths: [IndexPath]) {
        chooseRecipeViewModel.deleteRecipe(id: id) { [weak self] in
            guard let self = self else { return }
            self.chooseRecipeViewModel.recipes.remove(at: indexPaths[0].row)
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        } failure: { (error) in
            print(error)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChooseRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chooseRecipeViewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier()) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.recipe = chooseRecipeViewModel.recipes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if chooseRecipeViewModel.isSelectedRecipes(indexPath: indexPath.row) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    // Setup trailing swipes.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath ) -> UISwipeActionsConfiguration? {
        let deleteAction = setupDeleteAction { [weak self] in
            guard let self = self else { return }
            guard let id = self.chooseRecipeViewModel.recipes[indexPath.row].id else {
                return
            }
            self.deleteRecipe(id: id, indexPaths: [indexPath])
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

