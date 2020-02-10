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
    
    //ANIMATION Step 1:
    // do not forge LAZY var!!!
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
        
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
    
    public lazy var newImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true // keeps image inside the bounds
        iv.alpha = 0
        return iv
    }()
    
    private var isShowingImage = false
        
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
            setupNewImageView()
            
            //ANIMATION Step 3:
            addGestureRecognizer(longPressGesture) // it does not work because the label is covers the ce;; -> we need to do label.isuseriteraction Enabled = true
           articleTitle.isUserInteractionEnabled = true
        }
    
    //ANIMATION Step 2:
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
       // print("outside gesture")
        guard let currentArticle = currentArticle else { return }
        if  gesture.state == .began || gesture.state == .changed {
           // print("long pressed")
            return
        }
        
        isShowingImage.toggle() // true -> false -> true
        
        newImageView.getImage(with: currentArticle.getArticleImageURL(for: .normal)) {[weak self](result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newImageView.image = image
                    self?.animate()
                }
            }
        }
    }
    
    private func animate() {
        let duration: Double = 1.0 // seconds
        if isShowingImage {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.newImageView.alpha = 1.0
                self.articleTitle.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.newImageView.alpha = 0.0
                self.articleTitle.alpha = 1.0
            }, completion: nil)
        }
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
    
    private func setupNewImageView() {
        addSubview(newImageView)
        newImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            newImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
        
        public func configureCell(for savedArticle: Article){
            articleTitle.text = savedArticle.title
            currentArticle = savedArticle // associating the cell with its article
            articleTitle.text = savedArticle.title
        }
        
    }
