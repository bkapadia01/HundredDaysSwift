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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
