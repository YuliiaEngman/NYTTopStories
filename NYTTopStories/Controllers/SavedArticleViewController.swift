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
    
    private let savedArticleView = SavedArticleView()
    
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
          // print("there are \(savedArticles.count) articles")
            savedArticleView.collectionView.reloadData()
            if savedArticles.isEmpty {
                // setup our empty view on the collection
                savedArticleView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by typping on the News icon.")
            } else {
                //remove empty view from collection view background view
                savedArticleView.collectionView.backgroundView = nil
            }
        }
    }
    
    override func loadView() {
        view = savedArticleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        // DP Step 13. Call the function
        fetchSavedArticles()
        
        //setup collectiob view
        savedArticleView.collectionView.dataSource = self
        savedArticleView.collectionView.delegate = self
        
        savedArticleView.collectionView.register(SavedArticleCell.self, forCellWithReuseIdentifier: "savedArticleCell")
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

extension SavedArticleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath) as? SavedArticleCell else {
            fatalError("could not downcast to SavedArticleCell")
        }
        let savedArticle = savedArticles[indexPath.row]
        cell.backgroundColor = .systemBackground
        cell.configureCell(for: savedArticle)
        
        // STEP 4 DELEGATE - Register a delegate - we get an error so go to step 5 (extension)
        cell.delegate = self
        
        return cell
    }
}

// item size here not in UICollectionViewDelegate
extension SavedArticleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // return CGSize - width and height of the item
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let numberOfItems: CGFloat = 2
        let itemHeight: CGFloat = maxSize.height * 0.30
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing) / numberOfItems
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // this is spacing aroud your whole collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
    }
    
    // segue programmatically
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = savedArticles[indexPath.row]
        let detailVC = ArticleDetailViewController()
        detailVC.article = article
        // we need to pass it over - other way it will be nil abd crash
        // we have method to check if the object was already saved (avoid duplicates) - go to Alex's Github -> DataPersistance -. .hasItemBeedSaved
        detailVC.dataPersistance = dataPersistance
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


// DP Step 10. Conforming to the DataPersistanceDelegate
extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        fetchSavedArticles() // using it to test

    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        //print("item was deleted")
        fetchSavedArticles()
    }
}

// Step 5 TO SET DELEGATION
extension SavedArticleViewController: SavedArticlwCellDelegate {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article) {
        print("didSelectMoreButton: \(article.title)")
        
        // create action sheet
        // cancel action and delete action
        // post MVP shareAction
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            alertAction in
            self.deleteArticle(article)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
    }
    
    private func deleteArticle(_ article: Article) {
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        do {
            try dataPersistance.deleteItem(at: index)
        } catch {
            print("error deleting article: \(error)")
        }
    }
}

 
