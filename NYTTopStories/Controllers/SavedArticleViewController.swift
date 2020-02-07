//
//  SavedArticleViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticleViewController: UIViewController {
    
    // DP Step 9. Setting up data persistance  of the same instance we created in TabBarController
    // remember import DataPersistance
    public var dataPersistance: DataPersistence<Article>!
    
    // TODO: cfeate a savedArticleView
    //TODO: add a collection view to the avedArticleView
    // TODO: collection view is vertical with 2 cells per row
    //TODO: add avedArticleView to avedArticleViewController
    // create an array of savedArticle = [Article] - didSet
    // TODO: reload collection view in didSet of thesavedArticles array DataPersistance method

    // DP Step 11. Conforming to the DataPersistanceDelegate
    private var savedArticles = [Article]() {
        didSet {
            print("there are \(savedArticles.count) articles")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        // DP Step 13. Call the function
        //fetchSavedArticles()
    }
    
    // DP Step 12. Conforming to the DataPersistanceDelegate
    private func fetchSavedArticles(){
        do {
            savedArticles = try dataPersistance.loadItems()
        } catch {
            print("error fetching articles: \(error)")
        }
    }
}

// DP Step 10. Conforming to the DataPersistanceDelegate
extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        fetchSavedArticles() // using it to test

    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}
