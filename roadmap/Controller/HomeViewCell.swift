//
//  HomeViewCell.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/25.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    lazy var thumbNilImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var courseTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .label
        lb.font = .systemFont(ofSize: 30, weight: .bold)
        
        return lb
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUIComponents(){
        self.backgroundColor = .systemGray5
        
        self.addSubview(thumbNilImage)
        thumbNilImage.translatesAutoresizingMaskIntoConstraints = false
        thumbNilImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbNilImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        thumbNilImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        thumbNilImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        thumbNilImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func viewModel(course: Course){
        let url = URL(string: course.courseThumbnailUrl)
        
    }
}
