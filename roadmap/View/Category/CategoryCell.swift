//
//  categoryCell.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/28.
//

import UIKit
import SDWebImage

class CategoryCell: UICollectionViewCell {
    //MARK: -Propertiesk
    lazy var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemGray3
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        let url = URL(string: "https://picsum.photos/1920/1084")!
        imgView.sd_setImage(with: url)
        imgView.layer.cornerRadius = 35
        
        return imgView
    }()
    lazy var categoryTitle: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14, weight: .bold)
        lb.textColor = .white
        
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
    
    //MARK: - Helper
    func configureUIComponents(){
        self.addSubview(bgImageView)
        self.addSubview(categoryTitle)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        bgImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        categoryTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
    }
    
    func viewModel(category: Category) {
        categoryTitle.text = category.placeSido
    }
}

