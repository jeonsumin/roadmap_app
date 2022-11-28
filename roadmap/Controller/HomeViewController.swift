//
//  HomeViewController.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/25.
//

import UIKit
import Alamofire
import SwiftUI

let courseCellIdentifier = "courseCell"
class HomeViewController: UICollectionViewController {

    var courseList = [Course]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponents()
        
        ///get Data
        getData()
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: courseCellIdentifier)
        
        
        ///UICollection Layout 설정
        collectionView.collectionViewLayout = layout()
    }
    
    //MARK: - Function
    private func getData(){
        RoadmapApi.shard.getCourseList(completionHandler: { result in
            switch result {
            case .success(let data):
                self.courseList = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self ] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch sectionNumber{
            case 0:
                return self.courseBannerSecion()
            default:
                return nil
            }
        }
    }
    
    private func courseBannerSecion() -> NSCollectionLayoutSection {
        //itme
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        

        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
}

//MARK: - UICollectionView Protocol
extension HomeViewController {
    
    /// 섹션별 셀 설정
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return courseList.count
        default :
            return 0
        }
        
    }
    
    /// 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: courseCellIdentifier, for: indexPath) as! HomeViewCell
            return cell
        default :
            return UICollectionViewCell()
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}



//SwiftUI를 활용한 미리보기
struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewControllerRepresentable().edgesIgnoringSafeArea(.all)
    }
}
struct HomeViewControllerRepresentable:UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let layout = UICollectionViewLayout()
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        return UINavigationController(rootViewController: homeViewController)
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        typealias UIViewControllerType = UIViewController
    }
}
