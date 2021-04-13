//
//  LoginView.swift
//  RecipesApp
//
//  Created by Mac on 4/13/21.
//

import UIKit

class LoginViewController: UIViewController {
    let loginViewModel: LoginViewModel
    
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегестрироваться", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBarWith(title: "LOGIN")
        addSubviews()
        setupConstraints()
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        descriptionLabel.text = "Войдите в систему!"
    }

    // The object View Model which comes to the init.
    required init(_ loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
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
        stackView.addArrangedSubview(loginButton)
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
            $0.height.equalTo(200)
        }
    }

    @objc private func login() {
        loginViewModel.loginUser(email: loginTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] in
            guard let self = self else { return }
            self.loginTextField.text = ""
            self.passwordTextField.text = ""
            let vc = MainTabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } failure: { [weak self] (error) in
            guard let self = self else { return }
            self.showDefaultErrorAlert()
        }
    }
    
    @objc private func register() {
        let vc = RegistrationViewController(appContainer.prepareRegistrationViewModel())
        navigationController?.pushViewController(vc, animated: true)
    }
}
