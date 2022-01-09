//
//  MoreInfoViewController.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 07/01/2022.
//

import UIKit

class MoreInfoViewController: UIViewController {
    
    var githubName: String!
    var repoName: String!
    var moreInfo : MoreInfo!
    var contributors: Contributor?
    
    
    private let padding :CGFloat = 15
    private let scrollView = UIScrollView()
    private let conteinerView = UIView()
    private var heightOfScrollView: CGFloat = 0
    
    
    private let aboutLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let topicsCollectionViewReuseIdentifier = "topicsCollectionViewReuseIdentifier"
    private var topicsCollectionView : UICollectionView!
    
    private let languageView = UIView()
    private let languageLabel = UILabel()
    
    private let forksCountView = UIView()
    private let forksLabel = UILabel()
    
    private let stargazersCountView = UIView()
    private let stargazersCountLabel = UILabel()
    
    private let licenseView = UIView()
    private let licenseLabel = UILabel()
    
    private let stackView = UIStackView()
    
    private let contributorsLabel = UILabel()
    private let contributorsTableView = UITableView()
    private let contributorsTableViewCellIdentifier = "contributorsTableViewCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = repoName
        
        RepositoriesHelper.shared.getMoreInfo(gitHubName: githubName, repoName: repoName) { [self] result in
            moreInfo = result
            DispatchQueue.main.async {
                view.addSubview(scrollView)
                scrollView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
                scrollView.contentSize = CGSize(width: view.frame.size.width, height: 2000)
                
                scrollView.addSubview(conteinerView)
                conteinerView.frame.size = CGSize(width: view.frame.size.width, height: 2000)
                
                conteinerView.addSubview(aboutLabel)
                configureAboutLabel()
                
                conteinerView.addSubview(descriptionLabel)
                configureDescriptionLabel()
                
                configureTopicsCollectionView()
                
                conteinerView.addSubview(stackView)
                configureStackView()
                
                conteinerView.addSubview(contributorsLabel)
                configureContributorsLabel()
                
                conteinerView.addSubview(contributorsTableView)
                configureTableView()
            }
            RepositoriesHelper.shared.getContributorData(gitHubName: githubName, repoName: repoName) { result in
                contributors = result
                DispatchQueue.main.async {
                    contributorsTableView.reloadData()
                }
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        reloadUI()
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: heightOfScrollView)
        conteinerView.frame.size = CGSize(width: view.frame.size.width, height: heightOfScrollView)
    }
    
    private func configureTableView() {
        contributorsTableView.register(ContributorTableViewCell.self, forCellReuseIdentifier: contributorsTableViewCellIdentifier)
        setTableViewDelegates()
        contributorsTableView.rowHeight = 50
        contributorsTableView.separatorStyle = .none
        contributorsTableView.showsVerticalScrollIndicator = false
        
        
        contributorsTableView.translatesAutoresizingMaskIntoConstraints = false
        contributorsTableView.topAnchor.constraint(equalTo: contributorsLabel.bottomAnchor).isActive = true
        contributorsTableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        contributorsTableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
        //contributorsTableView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        //heightOfScrollView += 200
    }
    
    private func reloadUI(){
        topicsCollectionView.reloadData()
        
        var height = self.topicsCollectionView.contentSize.height //actual coll view hejggt
        heightOfScrollView += height
        self.topicsCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.topicsCollectionView.layoutIfNeeded()
        
        height = descriptionLabel.frame.size.height //actual desc label height
        heightOfScrollView += height + 15 //additional 15 bsc of padding
        
        if let tempHeight = contributors?.count {
            height = CGFloat(tempHeight * 50)
        } else {
            height = 0
        }
        
        contributorsTableView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        heightOfScrollView = heightOfScrollView + CGFloat(height)

    }
    private func configureAboutLabel(){
        aboutLabel.text = "About"
        aboutLabel.textColor = .orange
        aboutLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor).isActive = true
        aboutLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        //aboutLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: padding).isActive = true
        
        heightOfScrollView += 25
    }
    private func configureContributorsLabel(){
        contributorsLabel.text = "Contributors"
        contributorsLabel.textColor = .orange
        contributorsLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        contributorsLabel.translatesAutoresizingMaskIntoConstraints = false
        contributorsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding).isActive = true
        contributorsLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        
        heightOfScrollView += 40
    }
    
    private func configureDescriptionLabel(){
        descriptionLabel.text = moreInfo?.moreInfoDescription ?? ""
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: padding).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -padding).isActive = true
    }
    
    private func configureTopicsCollectionView(){
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        
        layout.estimatedItemSize = CGSize(width: 60, height: 25) //since the labels are "auto-self-sizing", the height is actual height of the cell
        topicsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        topicsCollectionView.dataSource = self
        topicsCollectionView.delegate = self
        
        topicsCollectionView.backgroundColor = .white
        topicsCollectionView.register(TopicsCollectionViewCell.self, forCellWithReuseIdentifier: topicsCollectionViewReuseIdentifier)
        
        conteinerView.addSubview(topicsCollectionView)
        topicsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        topicsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        topicsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        topicsCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: padding).isActive = true
        topicsCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 600).isActive = true
        
    }
    
    private func configureStackView(){
        ///Language/////////////
        let languageImage = UIImage(systemName: "swift")
        let languageImageView = UIImageView(image: languageImage)
        languageImageView.tintColor = .orange
        let languageRatio = Double((languageImage?.size.width)!) / Double((languageImage?.size.height)!)
        let languageHeight :Double  = 25
        let languageWidth = languageHeight * languageRatio
        languageView.addSubview(languageImageView)
        
        languageImageView.translatesAutoresizingMaskIntoConstraints = false
        languageImageView.topAnchor.constraint(equalTo: languageView.topAnchor).isActive = true
        languageImageView.leadingAnchor.constraint(equalTo: languageView.leadingAnchor).isActive = true
        languageImageView.heightAnchor.constraint(equalToConstant: CGFloat(languageHeight)).isActive = true
        languageImageView.widthAnchor.constraint(equalToConstant: CGFloat(languageWidth)).isActive = true
        
        languageView.addSubview(languageLabel)
        languageLabel.text = "Language: \(moreInfo?.language ?? "empty")"
        languageLabel.font = UIFont.systemFont(ofSize: 15)
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.leadingAnchor.constraint(equalTo: languageView.leadingAnchor, constant: 35).isActive = true
        languageLabel.topAnchor.constraint(equalTo: languageView.topAnchor).isActive = true
        languageLabel.heightAnchor.constraint(equalToConstant: CGFloat(languageHeight)).isActive = true
        ///ForksCount////////
        let forksImage = UIImage(systemName: "point.topleft.down.curvedto.point.bottomright.up")
        let forksImageView = UIImageView(image: forksImage)
        forksImageView.tintColor = .orange
        let forksRatio = Double((forksImage?.size.width)!) / Double((forksImage?.size.height)!)
        let forksHeight :Double  = 25
        let forksWidth = forksHeight * forksRatio
        forksCountView.addSubview(forksImageView)
        forksCountView.addSubview(forksLabel)
        
        forksImageView.translatesAutoresizingMaskIntoConstraints = false
        forksImageView.topAnchor.constraint(equalTo: forksCountView.topAnchor).isActive = true
        forksImageView.leadingAnchor.constraint(equalTo: forksCountView.leadingAnchor).isActive = true
        forksImageView.heightAnchor.constraint(equalToConstant: CGFloat(forksHeight)).isActive = true
        forksImageView.widthAnchor.constraint(equalToConstant: CGFloat(forksWidth)).isActive = true
        
        forksLabel.text = moreInfo.forksCount == 1 ? "\(moreInfo.forksCount) fork" : "\(moreInfo.forksCount) forks"
        forksLabel.font = UIFont.systemFont(ofSize: 15)
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        forksLabel.leadingAnchor.constraint(equalTo: forksCountView.leadingAnchor, constant: 35).isActive = true
        forksLabel.topAnchor.constraint(equalTo: forksCountView.topAnchor).isActive = true
        forksLabel.heightAnchor.constraint(equalToConstant: CGFloat(forksHeight)).isActive = true
        ///stargazersCount///////
        let stargazersCountImage = UIImage(systemName: "star.fill")
        let stargazersCountImageView = UIImageView(image: stargazersCountImage)
        stargazersCountImageView.tintColor = .orange
        let stargazersCountRatio = Double((stargazersCountImage?.size.width)!) / Double((stargazersCountImage?.size.height)!)
        let stargazersCountHeight :Double  = 25
        let stargazersCountWidth = stargazersCountHeight * stargazersCountRatio
        stargazersCountView.addSubview(stargazersCountImageView)
        stargazersCountView.addSubview(stargazersCountLabel)
        
        stargazersCountImageView.translatesAutoresizingMaskIntoConstraints = false
        stargazersCountImageView.topAnchor.constraint(equalTo: stargazersCountView.topAnchor).isActive = true
        stargazersCountImageView.leadingAnchor.constraint(equalTo: stargazersCountView.leadingAnchor).isActive = true
        stargazersCountImageView.heightAnchor.constraint(equalToConstant: CGFloat(stargazersCountHeight)).isActive = true
        stargazersCountImageView.widthAnchor.constraint(equalToConstant: CGFloat(stargazersCountWidth)).isActive = true
        
        stargazersCountLabel.text = moreInfo.stargazersCount == 1 ? "\(moreInfo.stargazersCount) star" : "\(moreInfo.stargazersCount) stars"
        stargazersCountLabel.font = UIFont.systemFont(ofSize: 15)
        stargazersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        stargazersCountLabel.leadingAnchor.constraint(equalTo: stargazersCountView.leadingAnchor, constant: 35).isActive = true
        stargazersCountLabel.topAnchor.constraint(equalTo: stargazersCountView.topAnchor).isActive = true
        stargazersCountLabel.heightAnchor.constraint(equalToConstant: CGFloat(stargazersCountHeight)).isActive = true
        ///licence /////////
        let licenceImage = UIImage(systemName: "graduationcap.fill")
        let licenceImageView = UIImageView(image: licenceImage)
        licenceImageView.tintColor = .orange
        let licenceRatio = Double((licenceImage?.size.width)!) / Double((licenceImage?.size.height)!)
        let licenceHeight :Double  = 25
        let licenceWidth = licenceHeight * licenceRatio
        licenseView.addSubview(licenceImageView)
        licenseView.addSubview(licenseLabel)
        
        licenceImageView.translatesAutoresizingMaskIntoConstraints = false
        licenceImageView.topAnchor.constraint(equalTo: licenseView.topAnchor).isActive = true
        licenceImageView.leadingAnchor.constraint(equalTo: licenseView.leadingAnchor).isActive = true
        licenceImageView.heightAnchor.constraint(equalToConstant: CGFloat(licenceHeight)).isActive = true
        licenceImageView.widthAnchor.constraint(equalToConstant: CGFloat(licenceWidth)).isActive = true
        
        licenseLabel.text = moreInfo.license?.name
        licenseLabel.font = UIFont.systemFont(ofSize: 15)
        licenseLabel.translatesAutoresizingMaskIntoConstraints = false
        licenseLabel.leadingAnchor.constraint(equalTo: licenseView.leadingAnchor, constant: 35).isActive = true
        licenseLabel.topAnchor.constraint(equalTo: licenseView.topAnchor).isActive = true
        licenseLabel.heightAnchor.constraint(equalToConstant: CGFloat(licenceHeight)).isActive = true
        
        stackView.addArrangedSubview(languageView)
        stackView.addArrangedSubview(forksCountView)
        stackView.addArrangedSubview(stargazersCountView)
        stackView.addArrangedSubview(licenseView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topicsCollectionView.bottomAnchor, constant: padding).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        heightOfScrollView += 150
    }
    
}


extension MoreInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moreInfo?.topics.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topicsCollectionViewReuseIdentifier, for: indexPath) as! TopicsCollectionViewCell
        
        cell.setLabelTitle(name: moreInfo.topics[indexPath.row])
        return cell
    }
}



extension MoreInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributors?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contributorsTableViewCellIdentifier, for: indexPath) as? ContributorTableViewCell else {
            fatalError("Bad Instance")
        }

        if let cont = contributors?[indexPath.row] {
            cell.setName(name: cont.login)
            RepositoriesHelper.shared.downloadImage(from: URL(string: cont.avatarURL)!) { image in
                cell.setImage(image: image)
            }
        } else {
            cell.setName(name:"")
        }
        cell.selectionStyle = .none
        return cell
    }
    
    private func setTableViewDelegates(){
        contributorsTableView.delegate = self
        contributorsTableView.dataSource = self
    }
}
