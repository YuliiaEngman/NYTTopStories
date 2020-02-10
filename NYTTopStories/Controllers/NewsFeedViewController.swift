//
//  NewsFeedViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedViewController: UIViewController {
    
    private let newsFeedView = NewsFeedView()
    
    // DP Step 5. Since we need an instance pass the article detailVC
    //we declaring instance we created in TabBarController
    //(remember import DataPersistance)
    public var dataPersistance: DataPersistence<Article>!
    
    // data for our collection view
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
                self.navigationItem.title = (self.newsArticles.first?.section.capitalized ?? "") + " News"
            }
        }
    }
    
    override func loadView() {
        view = newsFeedView
    }

    //STEP 5 USerDefaults:
    private var sectionNameInsideNewsFeedVC = "Technology"
//    didSet {
//        // TODO:
//    }

    // STEP 6: UserDefault:
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // white during the day and dark during the dark mode is on
        newsFeedView.collectionView.delegate = self
        newsFeedView.collectionView.dataSource = self
        
        // setup search bar
        newsFeedView.searchBar.delegate = self
        
        // register a collectionView cell
        // we use generic cell
//        newsFeedView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")
        
        // register a NewCell
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        
        //fetchStories()
    }
    
// Step 6 User Defaults:
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories()
    }
    
       private func fetchStories(for section: String = "Technology") {
        
        //STEP 4 USerDefaults:
        
        //retrieve section name from UserDefaults:
        if let sectionName = UserDefaults.standard.object(forKey: UserKey.sectionName) as? String {
           // self.sectionName = sectionName
            if sectionName != self.sectionNameInsideNewsFeedVC { // if business == business id does not reset my API - will not go below
                // we are looking at a new section
                // make a new query
                queryAPI(for: sectionName) // from SettingVC
                self.sectionNameInsideNewsFeedVC = sectionName
        } else {
            queryAPI(for: sectionName)
            }
        } else {
            // use the default section name
            queryAPI(for: sectionNameInsideNewsFeedVC) // from default Technology
        }

     }
    
    private func queryAPI(for section: String) {
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
    
    // this is the way how we segue to anothr VC
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let articleDVC = ArticleDetailViewController()
        
        // TODO: after assessment we will be using initializers as dependancy injection mechanism
        articleDVC.article = article
        
        // DP Step 6. Setting up data persistance and its delegate
        // passinge the persistance
        articleDVC.dataPersistance = dataPersistance
        
        // we cannot use navigation controller to push viewcontroller
        // UNTIL WE EMBADE IT TO NAVIGATION CONTROLLER
        navigationController?.pushViewController(articleDVC, animated: true)
        // because we have never embadded a navigationcontroller
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if newsFeedView.searchBar.isFirstResponder {
            newsFeedView.searchBar.resignFirstResponder()
        }
    }
}

extension NewsFeedViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("\(searchBar.searchTextField.text)")
//    }
    
    // changes while typing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // print(searchText)
        guard !searchText.isEmpty else {
            // if text is empty reload all the article
            fetchStories()
            return
        }
        // cv
        // filter artyicles based on searchText
        newsArticles = newsArticles.filter { $0.title.lowercased().contains(searchText.lowercased())}
    }
}
