//
//  MenuesView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import SnapKit
import UIKit

final class MenuesViewController: UIViewController {
    let menuesViewModel: MenuesViewModel
    
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
        tableView.register(MenueTableViewCell.self, forCellReuseIdentifier: MenueTableViewCell.identifier())
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // The object View Model which comes to the init.
    required init(_ menueViewModel: MenuesViewModel) {
        self.menuesViewModel = menueViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get object of AppTabBarController.
        setupLargeNavigationBarWith(title: "Menues")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addNewItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        addSubviews()
        setupConstraints()
        setupRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        getMenues()
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
        getMenues()
        refreshControl.endRefreshing()
    }
    
    @objc private func addNewItem() {
        let viewModel = appContainer.prepareCreateEditMenuViewModel(state: .create)
        let viewController = CreateEditMenuViewController(viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func logout() {
        menuesViewModel.logout {
            tabBarController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func getMenues() {
        menuesViewModel.getMenues() { [weak self] in
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
    
    private func deleteMenues(id: Int, indexPaths: [IndexPath]) {
        menuesViewModel.deleteMenue(id: id) { [weak self] in
            guard let self = self else { return }
            self.menuesViewModel.menues.remove(at: indexPaths[0].row)
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        } failure: { (error) in
            print(error)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MenuesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuesViewModel.menues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenueTableViewCell.identifier()) as? MenueTableViewCell else {
            return UITableViewCell()
        }
        cell.menue = menuesViewModel.menues[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = MenuViewController(appContainer.prepareMenuViewModel(menu: menuesViewModel.menues[indexPath.row]))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Setup trailing swipes.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath ) -> UISwipeActionsConfiguration? {
        let deleteAction = setupDeleteAction { [weak self] in
            guard let self = self else { return }
            guard let id = self.menuesViewModel.menues[indexPath.row].menueId else {
                return
            }
            self.deleteMenues(id: id, indexPaths: [indexPath])
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
