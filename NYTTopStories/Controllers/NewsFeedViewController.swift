//
//  NewsFeedViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private let newsFeedView = NewsFeedView()
    
    // data for our collection view
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = newsFeedView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // white during the day and dark during the dark mode is on
        newsFeedView.collectionView.delegate = self
        newsFeedView.collectionView.dataSource = self
        
        // register a collectionView cell
        // we use generic cell
//        newsFeedView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")
        
        // register a NewCell
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        
        fetchStroies()
    }
    
       private func fetchStroies(for section: String = "Technology") {
         NYTTopStoriesApIClient.fetchTopStories(for: section) {[weak self](result) in
             switch result {
             case .failure(let appError):
                 print("error fetching stories: \(appError)")
             case .success(let articles):
                // print("found \(articles.count)")
                self?.newsArticles = articles
             }
         }
     }

}

extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 50
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("could not downcast to NewsCell")
        }
        let article = newsArticles[indexPath.row]
        //cell.backgroundColor = .white
        cell.configureCell(with: article)
        return cell
    }
  
}

extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
