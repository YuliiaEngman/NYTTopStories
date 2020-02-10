//
//  EmptyView.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/10/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

    class EmptyView: UIView {
        
        // title and message
        
        public lazy var titleLabel: UILabel = {
           let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.numberOfLines = 1
            label.textAlignment = .center
            label.text = "Empty State"
            return label
        }()
        
        public lazy var messageLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.numberOfLines = 4
            label.textAlignment = .center
            label.text = "There are no items in your collection"
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        // CREATING OWN INITIALIZER: 
        init(title: String, message: String){
            super.init(frame: UIScreen.main.bounds)
            titleLabel.text = title
            messageLabel.text = message
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setupMessageLabelConstraints()
            setupTitleLabelConstraints()
        }
        
        private func setupMessageLabelConstraints() {
            addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        }
        
        private func setupTitleLabelConstraints(){
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        }
    }

