//
//  IngridientsView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import SnapKit
import UIKit

final class IngridientsViewController: UIViewController {
    let ingridientsViewModel: IngridientsViewModel
    
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
        tableView.register(IngridientTableViewCell.self, forCellReuseIdentifier: IngridientTableViewCell.identifier())
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    // The object View Model which comes to the init.
    required init(_ ingridientsViewModel: IngridientsViewModel) {
        self.ingridientsViewModel = ingridientsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get object of AppTabBarController.
        setupLargeNavigationBarWith(title: "Ingridients")
        addSubviews()
        setupConstraints()
        setupRefreshControl()
        tableView.delegate = self
        tableView.dataSource = self
        getIngridients()
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
        getIngridients()
        refreshControl.endRefreshing()
    }
    
    private func getIngridients() {
        ingridientsViewModel.getIngridients { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        } failure: { (error) in
            print(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension IngridientsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingridientsViewModel.ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngridientTableViewCell.identifier()) as? IngridientTableViewCell else {
            return UITableViewCell()
        }
        cell.ingridient = ingridientsViewModel.ingridients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = IngridientViewController(appContainer.prepareIngridientViewModel(ingridient: ingridientsViewModel.ingridients[indexPath.row]))
        navigationController?.pushViewController(viewController, animated: true)
    }
}
