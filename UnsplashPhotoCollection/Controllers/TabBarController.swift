//
//  TabBarController.swift
//  UnsplashPhotoCollection
//
//  Created by Ален Авако on 30.04.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarController()
        
        viewControllers = [createViewController(rootViewController: PhotosCollectionViewController(), title: "Photos", image: "photos"),
        createViewController(rootViewController: FavoritesTableViewController(), title: "Favorite", image: "like")]
    }
    
    private func setupTabBarController() {
        UITabBar.appearance().tintColor = .red
    }
    
    private func createViewController(rootViewController: UIViewController, title: String, image: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = UIImage(named: image)
        return navigationVC
    }
}
