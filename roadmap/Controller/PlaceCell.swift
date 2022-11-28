//
//  placeCell.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/28.
//

import UIKit

class PlaceCell: UICollectionViewCell {
    
    lazy var thumbNailImage: UIImageView = {
        let imgView = UIImageView()
        imgView.backgroundColor = .systemGray
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    lazy var placeName: UILabel = {
        let lb = UILabel()
        lb.text = "솥뚜껑생삼겹살"
        lb.font = .systemFont(ofSize: 20,weight: .bold)
        lb.textColor = .label
        lb.sizeToFit()
        return lb
    }()
    
    lazy var placeAddress: UILabel = {
        let lb = UILabel()
        lb.text = "성북구 동선동 4가"
        lb.font = .systemFont(ofSize: 14,weight: .bold)
        lb.textColor = .systemGray3
        return lb
    }()
    
    lazy var placeMcidName: UILabel = {
        let lb = UILabel()
        lb.text = "음식점"
        lb.font = .systemFont(ofSize: 14,weight: .regular)
        lb.textColor = .label
        return lb
    }()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUIComponents(){
    
        
        [
            thumbNailImage
            , placeName
            ,placeMcidName
            ,placeAddress
        ].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        thumbNailImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbNailImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        thumbNailImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbNailImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        thumbNailImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        placeName.leadingAnchor.constraint(equalTo: thumbNailImage.leadingAnchor,constant: 10).isActive = true
        placeName.topAnchor.constraint(equalTo: thumbNailImage.bottomAnchor,constant: 8).isActive = true
        placeName.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -30).isActive = true
        placeName.heightAnchor.constraint(equalToConstant: 24).isActive = true
    
        placeMcidName.leadingAnchor.constraint(equalTo: placeName.trailingAnchor,constant: 8).isActive = true
        placeMcidName.bottomAnchor.constraint(equalTo: placeName.bottomAnchor).isActive = true
//        placeMcidName.centerYAnchor.constraint(equalTo: placeName.centerYAnchor).isActive = true
        
        placeAddress.leadingAnchor.constraint(equalTo: placeName.leadingAnchor,constant: 8).isActive = true
        placeAddress.topAnchor.constraint(equalTo: placeName.bottomAnchor,constant: 8).isActive = true
    }
}
