//
//  RegistrationView.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    let registrationViewModel: RegistrationViewModel
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Логин"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.backgroundColor = UIColor.Base.accent
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: "REGISTRATION")
        addSubviews()
        setupConstraints()
        descriptionLabel.text = "Зарегистируйтесь в системе!"
    }

    // The object View Model which comes to the init.
    required init(_ registrationViewModel: RegistrationViewModel) {
        self.registrationViewModel = registrationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(descriptionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(loginTextField)
        stackView.addArrangedSubview(passwordTextField)
    }
    
    private func setupConstraints() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview().offset(12)
            $0.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(150)
        }
    }

    @objc private func login() {
    }
}
