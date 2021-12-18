//
//  ViewController.swift
//  project12
//
//  Created by Bhavin Kapadia on 2021-12-17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "useFaceId")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        
        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SaveDictionary")
        
        let saveInteger = defaults.integer(forKey: "Age")
        let saveBoolean = defaults.bool(forKey: "useFaceId")
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let saveDictionary = defaults.object(forKey: "SaveDictionary") as? [String: String] ?? [String: String]()
        
        
    }


}

