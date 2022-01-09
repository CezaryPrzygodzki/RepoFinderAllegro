//
//  RepositoriesViewController.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 06/01/2022.
//

import Foundation
import UIKit

class RepositoriesViewController: UIViewController {
    
    var githubName: String!
    private let tableView = UITableView()
    private let tableViewCellIdentifier = "tableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        configureTableView()
        
        RepositoriesHelper.shared.getRepositories(gitUser: githubName, page: 1) { result in
            RepositoriesHelper.shared.repositories += result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            RepositoriesHelper.shared.repositories = []
        }
    }
    
    private func configureTableView() {
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        setTableViewDelegates()
        tableView.rowHeight = 50
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RepositoriesHelper.shared.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath) as? RepositoryTableViewCell else {
            fatalError("Bad Instance")
        }
        let repo = RepositoriesHelper.shared.repositories[indexPath.row]
        cell.textLabel?.text = repo.name
        return cell
    }
    
    private func setTableViewDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = RepositoriesHelper.shared.repositories[indexPath.row].name
        let moreInfoVC = MoreInfoViewController()
        moreInfoVC.repoName = repo
        moreInfoVC.githubName = githubName
        self.navigationController?.pushViewController(moreInfoVC, animated: true)
    }
}
