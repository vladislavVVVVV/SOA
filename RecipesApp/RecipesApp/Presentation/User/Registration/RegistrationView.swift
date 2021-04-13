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
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "E-mail"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегестрироваться", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: "REGISTRATION")
        addSubviews()
        setupConstraints()
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
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
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(registerButton)
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

    @objc private func register() {
        registrationViewModel.registerUser(username: loginTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextField.text ?? "") {
            self.loginTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            let vc = MainTabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } failure: { [weak self] (error) in
            guard let self = self else { return }
            self.showDefaultErrorAlert()
        }
    }
}
