//
//  SavedArticleCell.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/10/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

    class SavedArticleCell: UIView {
        
        // more button
        // article title
        // news image
        
        public lazy var moreButton: UIButton = {
           let button = UIButton()
            button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            return button
        }()
        
        public lazy var articleTitle: UILabel = {
           let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setupButtonConstraints()
        }
        
        private func setupButtonConstraints() {
            addSubview(moreButton)
            moreButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                moreButton.topAnchor.constraint(equalTo: topAnchor),
                moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                moreButton.heightAnchor.constraint(equalToConstant: 44),
                moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
            ])
        }
        
        private func setupArticleTitleConstraints() {
            addSubview(articleTitle)
            articleTitle.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
                articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
                articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
                articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
    }
