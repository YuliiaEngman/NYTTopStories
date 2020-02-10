//
//  SavedArticleCell.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/10/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

// SETUPS OUR CUSTOM PROTOCOL
// STEP 1 to create Custom Delegate
protocol SavedArticlwCellDelegate: AnyObject {
    func didSelectMoreButton(_ savedArticleCell: SavedArticleCell, article: Article)
}

class SavedArticleCell: UICollectionViewCell {
    
    // STEP 2 to create Custom Delegate: -> Step 3 goes to moreButtonPressed (below)
    // we need to make weak referance to VC (not strong reference)
    weak var delegate: SavedArticlwCellDelegate?
    
    private var currentArticle: Article!
        
        // more button
        // article title
        // news image
        
        public lazy var moreButton: UIButton = {
           let button = UIButton()
            button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
            // cell refers to cell
            button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
            return button
        }()
        
        public lazy var articleTitle: UILabel = {
           let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .title2)
            label.text = "The best headline I ever came across on NYT."
            label.numberOfLines = 0
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
            setupArticleTitleConstraints()
        }
    
    @objc // using when choosing selector
    private func moreButtonPressed(_ sender: UIButton) {
        print("button was pressed for article \(currentArticle.title)")
        
        // STEP 3 to create Custom Delegate - > Next step Setting delegate on the cell we are going to Cellforrow inside SavedArtticleVC
        delegate?.didSelectMoreButton(self, article: currentArticle)
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
        
        public func configureCell(for savedArticle: Article){
            articleTitle.text = savedArticle.title
            currentArticle = savedArticle // associating the cell with its article
            articleTitle.text = savedArticle.title
        }
        
    }
