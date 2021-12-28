//
//  DetailViewController.swift
//  milestone10_12
//
//  Created by Bhavin Kapadia on 2021-12-27.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedInterest: Interests?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let imageToLoad = selectedInterest?.interestingImagePath {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
}
