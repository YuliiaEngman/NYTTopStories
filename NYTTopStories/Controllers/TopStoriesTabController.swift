//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {
    
    private lazy var newsFeedVC: NewsFeedViewController = {
        let viewController = NewsFeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return viewController
    }()
    
    private lazy var savedArticlesVC: SavedArticleViewController = {
        let viewController = SavedArticleViewController()
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
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
        
        viewControllers = [newsFeedVC, savedArticlesVC, settingsVC]
    }
    
    
}
