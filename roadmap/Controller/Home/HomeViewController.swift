//
//  HomeViewController.swift
//  roadmap
//
//  Created by Terry on 2022/11/25.
//

import UIKit
import SwiftUI
import SDWebImage
import Alamofire
import SafariServices

let courseCellIdentifier = "courseCell"
let categoryCellIdentifier = "categoryCell"
let placeCellIdentifier = "placeCell"
let contentHeaderIdentifier = "headerCell"


class HomeViewController: UICollectionViewController {
   
    //MARK: - Properties
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
    
    
    var placeList = [Place]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    lazy var floatingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(floatingButton)
        return view
    }()
    
    lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "floating"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIComponents()
        
        ///get Data
        getMyCourseList()
        getCategory()
        getPlaceList()
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
        
        //header설정
        collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: contentHeaderIdentifier)
        
        ///UICollection Layout 설정
        collectionView.collectionViewLayout = layout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.viewfinder"), style: .plain, target: self, action: #selector(addCouse))
        navigationItem.rightBarButtonItem?.tintColor = .label
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "logo"), style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .label
        
        view.addSubview(floatingView)
        floatingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        floatingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        floatingView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floatingView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    private func getPlaceList(){
        RoadmapApi.init(path: "/api/getPlace", method: .get).getPlaceList { response in
            switch response {
            case .success(let result):
                self.placeList = result
            case .failure(let error):
                print("API Call Get Place List Error : \(error.localizedDescription)")
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 40, bottom: 0, trailing: 0)
        
        
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
//        group.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 0)
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 0, bottom: 20, trailing: 0)
        
        
        section.orthogonalScrollingBehavior = .continuous
    
        let sectionHeader = SectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        
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
    
    private func SectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //section header size
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        
        //SectionHeader Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 0)
        
        return sectionHeader
    }
    
    
    //MARK: - Object Function
    ///create Course
    @objc func addCouse(){
        let createViewController = CreateCourseViewController()
        let navVC = UINavigationController(rootViewController: createViewController)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
    }
    
    private func detailSidoData(sido: String) {
        
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
            return placeList.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: contentHeaderIdentifier, for: indexPath) as? ContentCollectionViewHeader else { fatalError("Coud't dequeue Header")}
            headerView.sectionName.text = "지역"
            return headerView
        }else{
            return UICollectionReusableView()
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
            cell.placeName.text = placeList[indexPath.row].placeName
            cell.placeAddress.text = placeList[indexPath.row].placeAddr
            cell.placeMcidName.text = placeList[indexPath.row].placeMcidName
            let url = URL(string: placeList[indexPath.row].placeThumbnailUrl!)
            
            cell.thumbNailImage.sd_setImage(with: url)
            
            return cell
        }
    }
    
    //섹션 개수
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // 셀 선택 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            //코스 섹션
            let courseDetailVC = CourseDetailViewController()
            courseDetailVC.courseList = self.courseList[indexPath.row]
            navigationController?.pushViewController(courseDetailVC, animated: true)
        case 1:
            //지역 섹선
            let sidoPlaceListVC = DetailSidoPlaceListViewController()
            let sido = categoryList[indexPath.row].placeSido
            
            let encodingStr = sido!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
            RoadmapApi.init(path: "/api/getPlace?name=\(encodingStr)", method: .get).getPlaceList {[weak self]
                response in
                guard let self = self else { return }
                switch response {
                case .success(let result):
                    sidoPlaceListVC.placeList = result
                    self.navigationController?.pushViewController(sidoPlaceListVC, animated: true)
                case .failure(let result):
                    print(result)
                }
            }
            
            sidoPlaceListVC.sido = sido
            
        default:
            //장소 섹션
//            https://map.naver.com/v5/entry/place/1754341923?c=127.0422434,37.5245443
            let placeUrl = "https://map.naver.com/v5/entry/place/\(placeList[indexPath.row].placeCode!)?c=\(placeList[indexPath.row].placePx!),\(placeList[indexPath.row].placePy!)"
            guard let URL = URL(string: placeUrl) else { return }
            let safariConfig = SFSafariViewController.Configuration()
            safariConfig.entersReaderIfAvailable = true
            
            let safari = SFSafariViewController(url: URL, configuration: safariConfig)
            safari.preferredBarTintColor = .white
            safari.preferredControlTintColor = .systemBlue
            present(safari,animated: true, completion: nil)
        }
    }
}

//MARK: - SwiftUI를 활용한 미리보기
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
