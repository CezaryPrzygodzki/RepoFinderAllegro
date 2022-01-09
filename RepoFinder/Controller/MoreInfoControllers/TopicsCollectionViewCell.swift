//
//  TopicsCollectionViewCell.swift
//  RepoFinder
//
//  Created by Cezary Przygodzki on 07/01/2022.
//

import UIKit

class TopicsCollectionViewCell: UICollectionViewCell {
    
    private let label = UILabel()
    override init(frame: CGRect) {
            super.init(frame: frame)
        addSubview(label)
        
        backgroundColor = .orange.withAlphaComponent(0.3)
        layer.cornerRadius = 6
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelTitle(name: String){
        label.text = name
    }
    
    
}
