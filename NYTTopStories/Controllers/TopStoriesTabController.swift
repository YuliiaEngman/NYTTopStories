//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence

class TopStoriesTabController: UITabBarController {
    
    
    // DP Step 1. Setting up data persistance (remember import DataPersistance)
    private var dataPersistance = DataPersistence<Article>(filename: "savedArticles.plist")
    
    private lazy var newsFeedVC: NewsFeedViewController = {
        let viewController = NewsFeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        // DP Step 2. Setting up data persistance
        viewController.dataPersistance = dataPersistance
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticleViewController = {
        let viewController = SavedArticleViewController()
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
        // DP Step 3. Setting up data persistance
        viewController.dataPersistance = dataPersistance
        // DP Step 4. Setting up data persistance 
        viewController.dataPersistance.delegate = viewController
        return viewController
    }()
    
    private lazy var settingsVC: SettingsViewController = {
        let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .yellow
        
        viewControllers = [UINavigationController(rootViewController: newsFeedVC),
                           UINavigationController(rootViewController: savedArticlesVC),
                           UINavigationController(rootViewController: settingsVC)]
    }
    
    
}
