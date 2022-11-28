//
//  SceneDelegate.swift
//  roadmap
//
//  Created by deepvisions on 2022/11/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        let layout = UICollectionViewFlowLayout()
        let homeViewController = HomeViewController(collectionViewLayout: layout)
        
        let HomeNav = UINavigationController(rootViewController: homeViewController)
        
        let searchViewController = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchViewController)
        
        let favoriteViewController = FavoriteViewController()
        let favoriteNav = UINavigationController(rootViewController: favoriteViewController)
        
        favoriteViewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        /// TabBarController
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([HomeNav, searchNav, favoriteNav], animated: false)
        tabBarController.tabBar.tintColor = .black
        
        /// homeViewController
        tabBarController.tabBar.items![0].image = UIImage(systemName: "house")
        tabBarController.tabBar.items![0].title = "홈"
        /// searchViewController
        tabBarController.tabBar.items![1].image = UIImage(systemName: "sparkle.magnifyingglass")
        tabBarController.tabBar.items![1].title = "검색"
        
        /// favoriteViewController
        tabBarController.tabBar.items![2].image = UIImage(systemName: "pin")
        tabBarController.tabBar.items![2].title = "즐겨찾기"
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

