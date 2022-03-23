//
//  ItemCollectionViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-27.
//

import UIKit


class ItemCollectionViewController: UICollectionViewController {
    
    var selection: String!

    var menuGroup = MenuGroupElement(menuGroupName: "", menuGroupImage: "", menuGroupSet: false, menuItems: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = menuGroup.menuGroupName
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        collectionView.reloadData()
    }

    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuGroup.menuItems.count
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? MenuItemCell else { fatalError("Unable to dequeue MenuItemCell") }
        let menuItems = menuGroup.menuItems
        print(menuItems)
        cell.MenuItemLabel.text = menuItems[indexPath.item].itemName
        cell.MenuItemPriceLabel.text = menuItems[indexPath.item].itemPrice
        let menuImageName = menuItems[indexPath.item].itemImage
        let imageAsset = UIImage(named: menuImageName!)
        let path = getDocumentDirectory().appendingPathComponent(menuGroup.menuGroupImage)
        cell.MenuItemImage.image = UIImage(contentsOfFile: path.path) ?? imageAsset
        cell.MenuItemImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.MenuItemImage.layer.borderWidth = 2
        cell.MenuItemImage.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)


            if(self.isEditing == true) {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuItem))

            } else {
                self.navigationItem.leftBarButtonItem = nil

            }
    }
    
    @objc func addNewMenuItem() {
        let itemAddEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "itemAddEditViewController") as! ItemAddEditViewController
        self.navigationController?.pushViewController(itemAddEditViewController, animated: true)
    }
}
