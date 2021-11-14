//
//  DetailViewController.swift
//  Project10_3a
//
//  Created by Bhavin Kapadia on 2021-11-07.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var xPicture: Int?
    var yPicture: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(xPicture, yPicture)
        title = "Picture \(xPicture!) of \(yPicture!)"
        navigationItem.largeTitleDisplayMode = .never
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
