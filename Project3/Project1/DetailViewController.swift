//
//  DetailViewController.swift
//  Project1
//
//  Created by Bhavin Kapadia on 2021-05-09.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!

    
    var selectedImage: String?
    var xPicture: Int?
    var yPicture: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(xPicture!, yPicture!)
        title = "Picture \(xPicture!) of \(yPicture!)"
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad =  selectedImage {
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
    
    
    @objc func shareTapped() {
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("no image found")
            return
        }
        
        
        let vc = UIActivityViewController(activityItems: [image, selectedImage?.description.uppercased()], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
}
