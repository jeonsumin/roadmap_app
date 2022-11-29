//
//  CourseDetailViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/29.
//

import UIKit

class CourseDetailViewController:UIViewController {
    
    //MARK: - Properties
    var courseList: Course? 
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIComponents()
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        self.title = courseList?.courseTitle
    }
    
}
