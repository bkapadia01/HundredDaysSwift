//
//  ViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-19.
//

import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    var menuGroups = [MenuGroupElement]()
    var editModeEnabled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuGroup))
        self.navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.isEnabled = false

        
        guard let sourcePath = Bundle.main.url(forResource: "MenuGroupData", withExtension: "json") else {
            fatalError("Could not find json file")
        }
        
        if let data = try? Data(contentsOf: sourcePath) {
            parse(json: data)
        } else {
            fatalError("Could not access source path of json data")
        }
        
        if menuGroups.count > 0 {
            editButtonItem.isEnabled = true

        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuGroups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuGroup", for: indexPath) as? MenuGroupCell else {
            fatalError("MenuGroupCell could not be dequed")
        }
        
        let menuGroup = menuGroups[indexPath.item]
        cell.menuGroupName.text = menuGroup.menuGroupName
        
        let menuImageName = menuGroup.menuGroupImage
        let imageAsset = UIImage(named: menuImageName)
        let path = getDocumentDirectory().appendingPathComponent(menuGroup.menuGroupImage)
        cell.imageView.image = UIImage(contentsOfFile: path.path) ?? imageAsset
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuGroup = menuGroups[indexPath.item]
        
        if(menuGroup.menuGroupSet == true && editModeEnabled == true) {
            editMenu(indexPath: indexPath)
        } else if (menuGroup.menuGroupSet == true && editModeEnabled == false) {
            self.performSegue(withIdentifier: "ItemCollectionViewSegue", sender: self)

        }
        if(menuGroup.menuGroupSet == false) {
            renameMenu(indexPath: indexPath)
        }
        
    }
}

 
extension ViewController {
    
    func parse(json: Data) -> [MenuGroupElement]{
        let decoder = JSONDecoder()
        
        if let jsonMenuGroup = try? decoder.decode([MenuGroupElement].self, from: json) {
            menuGroups = jsonMenuGroup
            collectionView.reloadData()
        } else {
            fatalError("Data could not be parsed successfully")
        }
        return menuGroups
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let menuItemCollectiionVC: ItemCollectionViewController = segue.destination as? ItemCollectionViewController {
            if let indexPath = self.collectionView.indexPathsForSelectedItems {
                menuItemCollectiionVC.menuGroup = menuGroups[indexPath.last?.row ?? 0]
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if (editing) {
            editModeEnabled = true
        } else {
            editModeEnabled = false
        }
    }
    
    func renameMenu(indexPath: IndexPath) {
        let menuGroup = menuGroups[indexPath.row]
        
        let ac = UIAlertController(title: "Rename Menu Group", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac] _ in
            guard let newMenuGroupName = ac?.textFields?[0].text else { return }
            menuGroup.menuGroupName = newMenuGroupName
            menuGroup.menuGroupSet = true
            self?.collectionView.reloadData()
        })
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        
    }
    
    func deleteMenu(indexPath: IndexPath) {
        menuGroups.remove(at: indexPath.item)
        if(menuGroups.count < 1 ) {
            editButtonItem.isEnabled = false
            setEditing(false, animated: true)
         }
        collectionView.reloadData()
    }
    
    func editMenu(indexPath: IndexPath) {
        let ac = UIAlertController(title: "Edit Menu", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Rename Menu", style: .default, handler: {[weak self] _ in self?.renameMenu(indexPath: indexPath)}))
        ac.addAction(UIAlertAction(title: "Delete Menu", style: .default, handler: {[weak self] _ in self?.deleteMenu(indexPath: indexPath)}))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func addNewMenuGroup() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let menuGroup = MenuGroupElement(menuName: "Click To Set Name", image: imageName, menuSet: false, menuItem: [])
        menuGroups.append(menuGroup)
        picker.delegate = nil
        collectionView.reloadData()
        editButtonItem.isEnabled = true
        dismiss(animated: true)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
}
