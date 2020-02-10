//
//  TopStoryModel.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import Foundation

enum ImageFormat: String {
    case superJumbo = "superJumbo"
    case thumbLarge = "thumbLarge"
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
}

/*
    "multimedia": [
        {
            "url": "https://static01.nyt.com/images/2020/02/06/multimedia/00consent-01/00consent-01-superJumbo-v2.jpg",
            "format": "superJumbo",
            "height": 1365,
            "width": 2048,
            "type": "image",
            "subtype": "photo",
            "caption": "Two of Harvey Weinstein’s accusers had sex with him after their alleged assaults. As the jurors begin to debate, they will be in largely uncharted legal territory.",
            "copyright": "John Taggart for The New York Times"
        },
        {
            "url": "https://static01.nyt.com/images/2020/02/06/multimedia/00consent-01/00consent-01-thumbStandard-v3.jpg",
            "format": "Standard Thumbnail",
            "height": 75,
            "width": 75,
            "type": "image",
            "subtype": "photo",
            "caption": "Two of Harvey Weinstein’s accusers had sex with him after their alleged assaults. As the jurors begin to debate, they will be in largely uncharted legal territory.",
            "copyright": "John Taggart for The New York Times"
        },
        {
            "url": "https://static01.nyt.com/images/2020/02/06/multimedia/00consent-01/00consent-01-thumbLarge-v3.jpg",
            "format": "thumbLarge",
            "height": 150,
            "width": 150,
            "type": "image",
            "subtype": "photo",
            "caption": "Two of Harvey Weinstein’s accusers had sex with him after their alleged assaults. As the jurors begin to debate, they will be in largely uncharted legal territory.",
            "copyright": "John Taggart for The New York Times"
        },
        {
            "url": "https://static01.nyt.com/images/2020/02/06/multimedia/00consent-01/00consent-01-mediumThreeByTwo210-v3.jpg",
            "format": "mediumThreeByTwo210",
            "height": 140,
            "width": 210,
            "type": "image",
            "subtype": "photo",
            "caption": "Two of Harvey Weinstein’s accusers had sex with him after their alleged assaults. As the jurors begin to debate, they will be in largely uncharted legal territory.",
            "copyright": "John Taggart for The New York Times"
        },
        {
            "url": "https://static01.nyt.com/images/2020/02/06/multimedia/00consent-01/00consent-01-articleInline-v2.jpg",
            "format": "Normal",
            "height": 127,
            "width": 190,
            "type": "image",
            "subtype": "photo",
            "caption": "Two of Harvey Weinstein’s accusers had sex with him after their alleged assaults. As the jurors begin to debate, they will be in largely uncharted legal territory.",
            "copyright": "John Taggart for The New York Times"
        }
 */

struct TopStories: Codable & Equatable {
       let section: String
       let lastupdated: String // updated from last_updated
       let results: [Article]
       private enum CodingKeys: String, CodingKey {
           case section
           case lastupdated = "last_updated"
           case results
       }
   }
   
   struct Article: Codable & Equatable {
       let section: String
       let title: String
       let abstract: String
       let publishedDate: String
       let multimedia: [Multimedia]?
       private enum CodingKeys: String, CodingKey {
           case section
           case title
           case abstract
           case publishedDate = "published_date"
           case multimedia
       }
   }
   
   struct Multimedia: Codable & Equatable {
       let url: String
       let format: String // we are targeting SuperJumbo &
       let height: Double
       let width: Double
       let caption: String
   }


extension Article { // article.getArticleImageURL(.superJumbo)
    func getArticleImageURL(for imageFormat: ImageFormat) -> String { // we created enum to make it type safe instead that we will not make mistake in code
        guard let multimedia = multimedia else { return ""}
        let results = multimedia.filter { $0.format == imageFormat.rawValue } // means "thumbLarge" == "thumbLarge"
        guard let multimediaImage = results.first else { // if result is 0 i return "Normal" image
            return ""
        }
        return multimediaImage.url
    }
}
