//
//  SettingsViewController.swift
//  NYTTopStories
//
//  Created by Yuliia Engman on 2/6/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

// STEP @ USER DEFAULTS
struct UserKey {
    static let sectionName = "News Section"
}

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    
    //data for our pickerview
    private let sections = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "RealeEstate", "Science", "Sports", "SundayReview", "Technology", "Theater", "T-Magazine", "Travel", "Upshot", "US", "World"] // ascending from a -> z
    
    override func loadView() {
        view = settingsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        // setup picker view
        settingsView.pickerView.dataSource = self
        settingsView.pickerView.delegate = self
    }
    
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
    
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row] // accessing each individual astring in the sections array
    }
    
    // TODO: UserDefaults STEP 1 - chose picker and return inside main VC title and section
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // store the current selected news section in user defaults
       // print("section was selected \(sections[row])")
        let sectionName = sections[row]
        //STEP 3 USefDefaults -> go to NewsFeed Controller
        
        UserDefaults.standard.set(sectionName, forKey: UserKey.sectionName)
    }
}


