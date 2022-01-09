//
//  ContributorTableViewCell.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 08/01/2022.
//

import UIKit

class ContributorTableViewCell: UITableViewCell {
    
    private let contributorImageView = UIImageView()
    private let contributorNameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contributorImageView)
        configureImageView()
        contentView.addSubview(contributorNameLabel)
        configureNameLabel()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setName(name: String){
        contributorNameLabel.text = name
    }
    func setImage(image: UIImage){
        contributorImageView.image = image
    }
    private func configureImageView() {
        contributorImageView.layer.borderWidth = 2
        contributorImageView.layer.borderColor = UIColor.orange.cgColor
        
        
        contributorImageView.translatesAutoresizingMaskIntoConstraints = false
        contributorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        contributorImageView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        contributorImageView.widthAnchor.constraint(equalToConstant: 38).isActive = true
        contributorImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        contributorImageView.layer.cornerRadius = 19
        contributorImageView.layer.masksToBounds = false
        contributorImageView.clipsToBounds = true
    }
    
    private func configureNameLabel(){
        contributorNameLabel.font = UIFont.systemFont(ofSize: 15)
        
        contributorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contributorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contributorNameLabel.leadingAnchor.constraint(equalTo: contributorImageView.trailingAnchor, constant: 10).isActive = true
        contributorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        contributorNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
}
