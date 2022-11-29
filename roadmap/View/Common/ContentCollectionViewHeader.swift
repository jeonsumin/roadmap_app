//
//  CategoryHeaderCell.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/29.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionName = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionName.font = .systemFont(ofSize: 17,weight: .bold)
        
        sectionName.textColor = .label
        sectionName.sizeToFit()
        
        addSubview(sectionName)
        sectionName.translatesAutoresizingMaskIntoConstraints = false
        sectionName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sectionName.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        sectionName.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        sectionName.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        
    }
}
