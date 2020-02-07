//
//  ArticleDetailView.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/7/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    
    // image view
    // abstract headline
    // byLine
    // date
    
    public lazy var newsImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.backgroundColor = .yellow
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    public lazy var abstractHeadline: UILabel = {
           let label = UILabel()
           label.numberOfLines = 0
           label.textAlignment = .center
           label.font = UIFont.preferredFont(forTextStyle: .title3)
           label.text = "Abstract headline"
           return label
       }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setupNewsImageViewConstraints()
        setupAbstractHeadlineConstraints()
    }
    
    private func setupNewsImageViewConstraints(){
           addSubview(newsImageView)
           newsImageView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
               newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
               newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
               newsImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.40)
              // width of image become leading and trailing adge - so no need to add extra
           ])
       }
    
    private func setupAbstractHeadlineConstraints() {
          addSubview(abstractHeadline)
          abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
              abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
              abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
          ])
      }
    
}
