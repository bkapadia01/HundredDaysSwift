//
//  ItemCollectionViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-27.
//

import UIKit
import CoreData

class ItemCollectionViewController: UICollectionViewController {

    var menuGroupItems: [MenuItem]?
    var menuGroup: MenuGroups?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    var menuGroup = MenuGroupElement(menuGroupName: "", menuGroupImage: "", menuGroupSet: false, menuItems: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = menuGroup?.menuName
//        if let allMenuItems = menuGroup?.ofMenuItem?.allObjects as? [MenuItem] {
//            menuGroupItems = allMenuItems
//        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        fetchMenuGroupItems()
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuGroup?.menuItems?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? MenuItemCell else { fatalError("Unable to dequeue MenuItemCell") }
        let menuItems = menuGroup?.menuItems?[indexPath.row]
        item.menuItemLabel.text = menuItems?.itemName
        let itemPrceToTwoDecimalPlaces = String(format: "%.2f", menuItems?.itemPrice as! CVarArg)
        item.menuItemPriceLabel.text = "$ \( itemPrceToTwoDecimalPlaces )"
        let menuImageName = menuItems?.itemImage ?? ""
        let imageAsset = UIImage(named: menuImageName)
        let path = getDocumentDirectory().appendingPathComponent((menuItems?.itemImage)!)
        item.menuItemImage.image = UIImage(contentsOfFile: path.path) ?? imageAsset
        item.menuItemImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        item.menuItemImage.layer.borderWidth = 2
        item.menuItemImage.layer.cornerRadius = 3
        item.layer.cornerRadius = 7
        return item
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing == true {
            self.performSegue(withIdentifier: "MenuItemToDetailSegue", sender: indexPath)
        } else {
            showSelectedItemName(indexPath: indexPath)
        }
    }

    func showSelectedItemName(indexPath: IndexPath) {
        let menuItems = menuGroup?.menuItems?[indexPath.item]
        let itemName = menuItems?.itemName ?? ""
        let ac = UIAlertController(title: "You have selected: '\(String(describing: itemName))'", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "MenuItemToDetailSegue" {
            // REVIEW: This fixes the selected item not being currecly populated in the edit view controller but it causes a crash when you try to edit a newly created item
            let selectedIndexPath = sender as? NSIndexPath
            let itemDetailVC = segue.destination as! ItemAddEditViewController
            itemDetailVC.itemSelected = menuGroupItems?[selectedIndexPath?.item ?? 0]
        }
    }
    func fetchMenuGroupItems() {
        do {
            let fetchRequest =
                 NSFetchRequest<MenuItem>(entityName: "MenuItem")
             let sort = NSSortDescriptor(key: "itemDateCreated", ascending: false)
             fetchRequest.sortDescriptors = [sort]
            do {
                menuGroupItems = try context.fetch(fetchRequest)
               } catch let error as NSError {
                   print("Could not fetch. \(error), \(error.userInfo)")
               }
        }

    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }


    @objc func addNewMenuItem() {
        let itemAddEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "itemAddEditViewController") as! ItemAddEditViewController

        itemAddEditViewController.menuGroup = menuGroup
        self.navigationController?.pushViewController(itemAddEditViewController, animated: true)
    }
}

extension ItemCollectionViewController {
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing == true {

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuItem))

        } else {
            self.navigationItem.leftBarButtonItem = nil

        }
    }
}
