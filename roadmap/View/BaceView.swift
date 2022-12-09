//
//  BaceView.swift
//  roadmap
//
//  Created by deepvisions on 2022/12/06.
//

import UIKit

class BaceView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUIComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUIComponents(){
        backgroundColor = .brown
    }
}
