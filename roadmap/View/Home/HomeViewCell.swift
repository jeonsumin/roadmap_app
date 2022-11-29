//
//  HomeViewCell.swift
//  roadmap
//
//  Created by Terry on 2022/11/25.
//

import UIKit
import SDWebImage

class HomeViewCell: UICollectionViewCell {
    lazy var thumbNilImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        
        return img
    }()
    
    lazy var courseTitle: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
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
//        self.backgroundColor = .systemGray5
        self.backgroundColor = UIColor(hex: "#C85A46")
        
        self.addSubview(thumbNilImage)
        thumbNilImage.translatesAutoresizingMaskIntoConstraints = false
        thumbNilImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbNilImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        thumbNilImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        thumbNilImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbNilImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        thumbNilImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.addSubview(courseTitle)
        courseTitle.translatesAutoresizingMaskIntoConstraints = false
        courseTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        courseTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20).isActive = true
        courseTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -30).isActive = true
        courseTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func viewModel(course: Course){
        let url = URL(string: course.courseThumbnailUrl)!
        
        thumbNilImage.sd_setImage(with: url)
        
        courseTitle.text = course.courseTitle
    }
}
