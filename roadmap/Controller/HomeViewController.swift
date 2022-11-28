//
//  HomeViewController.swift
//  roadmap
//
//  Created by Terry on 2022/11/25.
//

import UIKit
import SwiftUI

let courseCellIdentifier = "courseCell"
let categoryCellIdentifier = "categoryCell"
let placeCellIdentifier = "placeCell"


class HomeViewController: UICollectionViewController {
    
    var courseList = [Course]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var categoryList = [Category]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponents()
        
        
        ///get Data
        getMyCourseList()
        getCategory()
        
    }
    
    //MARK: - Helper
    func configureUIComponents(){
        view.backgroundColor = .systemBackground
        
        //course cell register
        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: courseCellIdentifier)
        
        //category cell register
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        
        //place cell regiester
        collectionView.register(PlaceCell.self, forCellWithReuseIdentifier: placeCellIdentifier)
        ///UICollection Layout 설정
        collectionView.collectionViewLayout = layout()
        
        self.title = " "
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.viewfinder"), style: .plain, target: self, action: #selector(addCouse))
    }
    
    //MARK: - Function
    private func getMyCourseList(){
        RoadmapApi.init(path: "/api/getAllcourseList", method: .get).getCourseList { response in
            switch response{
            case .success(let result):
                self.courseList = result
            case .failure(let error):
                print("API Call getAllcourseList error: \(error.localizedDescription)")
            }
        }
    }
    private func getCategory(){
        RoadmapApi.init(path: "/api/categorySido", method: .get).getCetegoryList { response in
            switch response {
            case .success(let result):
                self.categoryList = result
            case .failure(let error):
                print("API Call Category error : \(error.localizedDescription)")
            }
        }
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self ] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            switch sectionNumber{
            case 0:
                return self.courseBannerSecion()
            case 1:
                return self.sidoListSection()
            default:
                return self.placeListSecion()
            }
        }
    }
    
    //코스 섹션
    private func courseBannerSecion() -> NSCollectionLayoutSection {
        //itme
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count:1 )
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    
    //카테고리 섹션
    private func sidoListSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    //장소 섹션
    private func placeListSecion() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    @objc func addCouse(){
        
    }
}

//MARK: - UICollectionView Protocol
extension HomeViewController {
    
    /// 섹션별 셀 개수 설정
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return courseList.count
        case 1:
            return categoryList.count
        default :
            return 3
        }
        
    }
    
    /// 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: courseCellIdentifier, for: indexPath) as! HomeViewCell
            cell.viewModel(course: courseList[indexPath.row])
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCell
            cell.viewModel(category: categoryList[indexPath.row])
            return cell
        default :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: placeCellIdentifier, for: indexPath) as! PlaceCell
            return cell
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
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
