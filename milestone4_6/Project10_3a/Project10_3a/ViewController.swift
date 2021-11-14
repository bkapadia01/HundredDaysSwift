//
//  ViewController.swift
//  Project10_3a
//
//  Created by Bhavin Kapadia on 2021-10-17.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [Pictures]()
    var pictureFiles = [String]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            
            // Do any additional setup after loading the view.
            let fm = FileManager.default
            let path = Bundle.main.resourcePath!
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            for item in items {
                if item.hasPrefix("nssl") {
                    // this is a picture to load
                    pictureFiles.sort()
                    pictureFiles.append(item)
                }
            }
            print(pictureFiles)
        }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureFiles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Error getting picture cell")
        }
        
        cell.name.text = pictureFiles[indexPath.item]
        print(pictureFiles[indexPath.item])
        cell.imageView.image = UIImage(named: pictureFiles[indexPath.item])

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictureFiles[indexPath.item]
            vc.xPicture = indexPath.item + 1
            vc.yPicture = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

