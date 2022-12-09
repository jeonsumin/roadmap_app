//
//  CreateCourseViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/28.
//

import UIKit
import SwiftUI
import SnapKit

class CreateCourseViewController:UIViewController {
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "제목"
        lb.font = .systemFont(ofSize: 14,weight: .bold)
        lb.textColor = .label
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let bottomLine = CALayer()
    
    lazy var titleInputTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .label
        tf.placeholder = "제목"
        
        return tf
    }()
    
    lazy var locationView: UIView = {
        let view = UIView()
        [locationLabel,locationField].forEach {  view.addSubview($0) }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var locationLabel:UILabel = {
        let lb = UILabel()
        lb.text = "지역"
        lb.font = .systemFont(ofSize: 14,weight: .bold)
        lb.textColor = .label
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    let locatoinBottomLine = CALayer()
    
    lazy var locationField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.textColor = .label
        tf.placeholder = "지역"
        //        tf.isUserInteractionEnabled = false
        tf.delegate = self
        
        let rigthView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: tf.frame.height))
        let downArrow = UIImageView(image: UIImage(systemName: "chevron.down"))
        downArrow.tintColor = .label
        tf.rightView = downArrow
        tf.rightViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var addPlaceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 14,weight: .bold)
        button.tintColor = .darkGray
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedAddPlaceButton), for: .touchUpInside)
        return button
    }()
    
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
    
    lazy var successButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20,weight: .bold)
        button.tintColor = .white
        button.layer.cornerRadius = 7
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setTitle("취소", for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        configureUIComponents()
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 50).isActive = true
        
        view.addSubview(successButton)
        
        successButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        successButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        successButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40).isActive = true
        successButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        
        
        view.addSubview(titleView)
        titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        titleView.addSubview(titleInputTextField)
        titleInputTextField.translatesAutoresizingMaskIntoConstraints = false
        titleInputTextField.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        titleInputTextField.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        titleInputTextField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        titleView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor,constant: 3).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleInputTextField.topAnchor).isActive = true
        
        bottomLine.frame = CGRect(x: 0, y:titleInputTextField.frame.size.height - 5 , width: titleInputTextField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        
        titleInputTextField.layer.addSublayer(bottomLine)
        
        view.addSubview(locationView)
        locationView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor).isActive = true
        locationView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor).isActive = true
        locationView.topAnchor.constraint(equalTo: titleView.bottomAnchor,constant: 20).isActive = true
        locationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationView.leadingAnchor).isActive = true
        locationLabel.topAnchor.constraint(equalTo: locationView.topAnchor).isActive = true
        locationLabel.bottomAnchor.constraint(equalTo: locationField.topAnchor).isActive = true
        
        locationField.leadingAnchor.constraint(equalTo: locationView.leadingAnchor).isActive = true
        locationField.trailingAnchor.constraint(equalTo: locationView.trailingAnchor).isActive = true
        locationField.heightAnchor.constraint(equalToConstant: 48).isActive = true
        locatoinBottomLine.frame = CGRect(x: 0, y:locationField.frame.size.height - 5 , width: locationField.frame.width, height: 1.0)
        locatoinBottomLine.backgroundColor = UIColor.black.cgColor
        
        
        locationField.layer.addSublayer(locatoinBottomLine)
        
        view.addSubview(addPlaceButton)
        addPlaceButton.topAnchor.constraint(equalTo: locationView.bottomAnchor,constant: 40).isActive = true
        addPlaceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        addPlaceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        addPlaceButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: addPlaceButton.bottomAnchor,constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
    }
    
    //MARK: - Function
    @objc
    func tappedBackButton(){
        navigationController?.dismiss(animated: true)
    }
    
    @objc
    func tappedAddPlaceButton(){
        print("Tapped Add Place Button ")
    }
    
}

extension CreateCourseViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == locationField {
            let bottomSheetVC = BottomSheetViewController()
            bottomSheetVC.modalPresentationStyle = .overFullScreen
            self.present(bottomSheetVC, animated: false)
            return false
        }
        return true
    }
}

extension CreateCourseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        
        return cell
    }
    
    
    
}

//MARK: - SwiftUI를 활용한 미리보기
struct CreateCourseViewController_Previews: PreviewProvider {
    static var previews: some View {
        CreateCourseViewControllerRepresentable().edgesIgnoringSafeArea(.all)
    }
}

struct CreateCourseViewControllerRepresentable:UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let layout = UICollectionViewLayout()
        let homeViewController = CreateCourseViewController()
        return UINavigationController(rootViewController: homeViewController)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        typealias UIViewControllerType = UIViewController
    }
}
