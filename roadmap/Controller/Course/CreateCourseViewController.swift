//
//  CreateCourseViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/28.
//

import UIKit

class CreateCourseViewController:UIViewController {
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel,titleInputTextField].forEach{
            view.addSubview($0)
        }
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "TITLE"
        lb.font = .systemFont(ofSize: 14,weight: .bold)
        lb.textColor = .label
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    lazy var titleInputTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
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
        
        view.addSubview(titleView)
        titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        titleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        titleInputTextField.widthAnchor.constraint(equalToConstant: 300 ).isActive = true
    }
    
    //MARK: - Function
    @objc
    func tappedBackButton(){
        navigationController?.dismiss(animated: true)
    }
}
