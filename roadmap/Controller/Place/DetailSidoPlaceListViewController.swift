//
//  DetailSidoPlaceListViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/29.
//

import UIKit
import SnapKit

class DetailSidoPlaceListViewController: UIViewController {
    //MARK: - Properties
    var placeList = [Place]()
    var sido: String?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        
        return collectionView
    }()
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIComponents()
        
        print("place List : \(placeList) ")
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        self.title = sido
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension DetailSidoPlaceListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return placeList.count
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
    
    
}
