//
//  ViewController.swift
//  Bankey
//
//  Created by Regina Williams on 1/30/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel = UILabel()
    var descLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
        layout()
        
    }


}


extension LoginViewController {
    private func configure() {
        
        titleLabel = makeLabel(with: "Bankey", size: 32)
        descLabel = makeLabel(with: "Your premium source for all things banking!", size: 26)
       
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.font = .boldSystemFont(ofSize: 20)
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = "Username / password cannot be blank"
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            descLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            descLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        
        ])
    }
}

// MARK: - Factories
extension LoginViewController {
    func makeLabel(with text:String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = text
        label.textAlignment = .center
        label.font = .systemFont(ofSize: size, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        return label
    }
}

//  MARK: - Actions
extension LoginViewController {
    
    @objc
    func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        // first get the user and password
        guard let username = username,
              let password = password else {
                  assertionFailure("Username / password should never be nil.")
                  return
              }
        
        if username.isEmpty || password.isEmpty {
            displayError(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "Regina" && password == "1234" {
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            displayError(withMessage: "Incorrect User and Password.")
        }
        
    }
    
    private func displayError(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    
}

