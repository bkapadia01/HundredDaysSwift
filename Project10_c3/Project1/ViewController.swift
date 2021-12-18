//
//  ViewController.swift
//  Project1
//
//  Created by Bhavin Kapadia on 2021-05-09.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictureFile = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load
                pictureFile.sort()
                pictureFile.append(item)
            }
        }

        print(pictureFile)
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        cell.name.text = pictureFile[indexPath.item]
        let picture = pictureFile[indexPath.item]
        let path = getDocumentsDirectory().appendingPathComponent(picture)
        if let image = UIImage(contentsOfFile: path.path) {
            cell.imageView.image = image
        } else {
            print("getImage() [Warning: file exists at \(path) :: Unable to create image]")

        }
        
    
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
//        collectionView.reloadData()
        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureFile.count

    }
    
    func getDocumentsDirectory() -> URL {


        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictureFile[indexPath.item]
//            vc.xPicture = indexPath.item + 1
//            vc.yPicture = pictureFile.count
//            print(pictureFile.count)
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
}

