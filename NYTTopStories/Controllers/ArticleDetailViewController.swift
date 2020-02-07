//
//  ArticleDetailViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    public var article: Article?
    
    private let articleDetailView = ArticleDetailView()
    
    override func loadView() {
        view = articleDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        updateUI()
        
        // programmatically setting up the right UIBarBarItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))

    }
    
    private func updateUI() {
        guard let article = article else {
            fatalError("did not oad article")
        }
        navigationItem.title = article.title
    }
    
    @objc
    func saveArticleButtonPressed(_ sender: UIBarButtonItem){
        print("saved article button pressed")
    }
    

}
