//
//  ViewController.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 06/01/2022.
//

import UIKit

class ViewController: UIViewController {

    private let userNameLabel = UILabel()
    private let gitUserTextField = UITextField()
    private let showRepositoriesButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userNameLabel)
        configureUserNameLabel()
        
        view.addSubview(gitUserTextField)
        configureGitUserTextField()
        
        view.addSubview(showRepositoriesButton)
        configureShowRepositoriesButton()
    }
    

    private func configureUserNameLabel(){
        userNameLabel.text = "Użytkownik GitHuba:"
        userNameLabel.textColor = .orange
        userNameLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func configureGitUserTextField(){
        gitUserTextField.leftViewMode = .always
        gitUserTextField.layer.masksToBounds = true
        gitUserTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))

        gitUserTextField.layer.borderColor = UIColor.orange.cgColor
        gitUserTextField.layer.borderWidth = 2
        
        gitUserTextField.translatesAutoresizingMaskIntoConstraints = false
        gitUserTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor).isActive = true
        gitUserTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        gitUserTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        gitUserTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureShowRepositoriesButton() {
        showRepositoriesButton.setTitle("Szukaj", for: .normal)
        showRepositoriesButton.setTitleColor(.white, for: .normal)
        showRepositoriesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        showRepositoriesButton.backgroundColor = .orange
    
        showRepositoriesButton.addTarget(self, action: #selector(showRepositories), for: .touchUpInside)
        
        showRepositoriesButton.translatesAutoresizingMaskIntoConstraints = false
        showRepositoriesButton.topAnchor.constraint(equalTo: gitUserTextField.bottomAnchor, constant: 10).isActive = true
        showRepositoriesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        showRepositoriesButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        showRepositoriesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    @objc private func showRepositories(_ sender: Any){
        let repositoriesVC = RepositoriesViewController()
        repositoriesVC.githubName = gitUserTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        repositoriesVC.modalPresentationStyle = .fullScreen
        repositoriesVC.title = gitUserTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        navigationController?.pushViewController(repositoriesVC, animated: true)
    }
}



