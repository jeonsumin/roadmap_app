//
//  DetailPlaceCell.swift
//  roadmap
//
//  Created by deepvisions on 2022/12/08.
//

import UIKit

class DetailPlaceCell: UICollectionViewCell {
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        configUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUIComponents(){
        self.backgroundColor = .brown
    }
}
