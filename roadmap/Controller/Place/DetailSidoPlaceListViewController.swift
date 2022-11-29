//
//  DetailSidoPlaceListViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/29.
//

import UIKit

class DetailSidoPlaceListViewController: UIViewController {
    //MARK: - Properties
    var placeList = [Place]()
    var sido: String?
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIComponents()
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        self.title = sido
    }
}
