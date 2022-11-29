//
//  CreateCourseViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/28.
//

import UIKit

class CreateCourseViewController:UIViewController {
    
    lazy var backBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        button.backgroundColor = .clear
            
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponents()
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        view.addSubview(backBtn)
        
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        
        
        backBtn.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
    }
    
    //MARK: - Function
    @objc
    func tappedBackButton(){
        navigationController?.dismiss(animated: true)
    }
}
