//
//  CreateEditIngridientViewController.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

class CreateEditIngridientViewController: UIViewController {
    let createEditIngridientViewModel: CreateEditIngridientViewModel
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
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
    
    private let fatStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    private let proteinStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        stackView.alignment = .leading
        return stackView
    }()
    
    private let carbStackView: UIStackView = {
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
    
    private let fatLabel: UILabel = {
        let label = UILabel()
        label.text = "Жиры"
        return label
    }()
    
    private let carbLabel: UILabel = {
        let label = UILabel()
        label.text = "Углеводы"
        return label
    }()
    
    private let proteinLabel: UILabel = {
        let label = UILabel()
        label.text = "Белки"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите имя"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let fatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите жиры"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let carbTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите углеводы"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let proteinTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите белки"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch createEditIngridientViewModel.state {
        case .create:
            setupLargeNavigationBarWith(title: "Create new ingridient")
        case .edit(let ingridient):
            setupLargeNavigationBarWith(title: "Edit \(ingridient.name ?? "ingridient")")
            nameTextField.text = ingridient.name
            fatTextField.text = String(ingridient.fats ?? 0)
            carbTextField.text = String(ingridient.carbohydrates ?? 0)
            proteinTextField.text = String(ingridient.proteins ?? 0)
        }
        saveButton.addTarget(self, action: #selector(saveItem), for: .touchUpInside)
        addSubviews()
        setupConstraints()
    }

    // The object View Model which comes to the init.
    required init(_ createEditIngridientViewModel: CreateEditIngridientViewModel) {
        self.createEditIngridientViewModel = createEditIngridientViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(saveButton)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(fatStackView)
        stackView.addArrangedSubview(carbStackView)
        stackView.addArrangedSubview(proteinStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        fatStackView.addArrangedSubview(fatLabel)
        fatStackView.addArrangedSubview(fatTextField)
        carbStackView.addArrangedSubview(carbLabel)
        carbStackView.addArrangedSubview(carbTextField)
        proteinStackView.addArrangedSubview(proteinLabel)
        proteinStackView.addArrangedSubview(proteinTextField)
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
        proteinLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        nameLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        fatLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        carbLabel.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        nameTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        proteinTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        carbTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
        fatTextField.snp.makeConstraints {
            $0.width.equalTo(200)
        }
    }
    
    @objc private func saveItem() {
       guard nameTextField.text != "" && fatTextField.text != "" && carbTextField.text != "" && proteinTextField.text != "" else {
            showDefaultErrorAlert()
            return
        }
        createEditIngridientViewModel.createEditIngridient(name: nameTextField.text ?? "", fats: Int(fatTextField.text ?? "") ?? 0, proteins: Int(proteinTextField.text ?? "") ?? 0, carbohydrates: Int(carbTextField.text ?? "") ?? 0) { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        } failure: { [weak self] (error) in
            guard let self = self else { return }
            self.showDefaultErrorAlert()
        }
    }
}
