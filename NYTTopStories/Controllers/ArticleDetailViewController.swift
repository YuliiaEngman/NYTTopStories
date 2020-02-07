//
//  ArticleDetailViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import ImageKit

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
        //TODO: refactor and setup in ArticleDetailView
        // e.g. articleDetailView.configureView(for article: article)
        guard let article = article else {
            fatalError("did not oad article")
        }
        navigationItem.title = article.title
        articleDetailView.abstractHeadline.text = article.abstract
        articleDetailView.newsImageView.getImage(with: article.getArticleImageURL(for: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.articleDetailView.newsImageView.image = UIImage(systemName: "exclamationmark-octogon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.articleDetailView.newsImageView.image = image
                }
            }
            
        }
    }
    
    @objc
    func saveArticleButtonPressed(_ sender: UIBarButtonItem){
        print("saved article button pressed")
    }
    

}
