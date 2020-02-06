//
//  TopStoryModel.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

struct TopStories: Codable {
       let section: String
       let lastupdated: String // updated from last_updated
       let results: [Article]
       private enum CodingKeys: String, CodingKey {
           case section
           case lastupdated = "last_updated"
           case results
       }
   }
   
   struct Article: Codable {
       let section: String
       let title: String
       let abstract: String
       let publishedDate: String
       let multimedia: [Multimedia]
       private enum CodingKeys: String, CodingKey {
           case section
           case title
           case abstract
           case publishedDate = "published_date"
           case multimedia
       }
   }
   
   struct Multimedia: Codable {
       let url: String
       let format: String
       let height: Double
       let width: Double
       let caption: String
   }
