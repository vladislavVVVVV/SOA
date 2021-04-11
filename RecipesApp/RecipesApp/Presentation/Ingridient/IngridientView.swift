//
//  IngridientView.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

class IngridientViewController: UIViewController {
    let ingridientViewModel: IngridientViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NutritionalValueTableViewCell.self, forCellReuseIdentifier: NutritionalValueTableViewCell.identifier())
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: ingridientViewModel.selectedIngridient.name ?? "Ingridient")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editItem))
        addSubviews()
        setupConstraints()
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }

    // The object View Model which comes to the init.
    required init(_ ingridientViewModel: IngridientViewModel) {
        self.ingridientViewModel = ingridientViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
    }

    @objc private func editItem() {
        let viewModel = appContainer.prepareCreateEditIngridient(state: .edit(ingridient: ingridientViewModel.selectedIngridient))
        let navigationViewController = UINavigationController(rootViewController: CreateEditIngridientViewController(viewModel))
        present(navigationViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension IngridientViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NutritionalValueTableViewCell.identifier()) as? NutritionalValueTableViewCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.name = "Белки"
            cell.valueNutrion = String(ingridientViewModel.selectedIngridient.proteins ?? 0)
        case 1:
            cell.name = "Углеводы"
            cell.valueNutrion = String(ingridientViewModel.selectedIngridient.carbohydrates ?? 0)
        case 2:
            cell.name = "Жиры"
            cell.valueNutrion = String(ingridientViewModel.selectedIngridient.fats ?? 0)
        default:
            cell.name = "БЖУ"
            cell.valueNutrion = String(0)
        }
        return cell
    }
}

