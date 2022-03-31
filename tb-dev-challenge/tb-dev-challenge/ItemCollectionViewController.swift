//
//  ItemCollectionViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-27.
//

import UIKit
import CoreData

class ItemCollectionViewController: UICollectionViewController {

    var selection: String!
    var menuGroupItems: [MenuItems]?
    var menuGroup: MenuGroups?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //    var menuGroup = MenuGroupElement(menuGroupName: "", menuGroupImage: "", menuGroupSet: false, menuItems: [])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = menuGroup?.menuName
        if let allMenuItems = menuGroup?.ofMenuItem?.allObjects as? [MenuItems] {
            menuGroupItems = allMenuItems
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchMenuGroupItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuGroup?.menuItems?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? MenuItemCell else { fatalError("Unable to dequeue MenuItemCell") }
        let menuItems = menuGroup?.menuItems?[indexPath.item]
        item.MenuItemLabel.text = menuItems?.itemName
        item.MenuItemPriceLabel.text = "\(menuItems?.itemPrice ?? 0.0)"
        let menuImageName = menuItems?.itemImage
        let imageAsset = UIImage(named: menuImageName!)
        let path = getDocumentDirectory().appendingPathComponent((menuItems?.itemImage)!)
        item.MenuItemImage.image = UIImage(contentsOfFile: path.path) ?? imageAsset
        item.MenuItemImage.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        item.MenuItemImage.layer.borderWidth = 2
        item.MenuItemImage.layer.cornerRadius = 3
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
        let itemName = menuItems?.itemName!
        let ac = UIAlertController(title: "You have selected: '\(String(describing: itemName!))'", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        if segue.identifier == "MenuItemToDetailSegue" {

            // REVIEW: This is buggy, I am unable to display the correct data for the selected cell. I am thinking of trying to use the commented code below but still not resolving the issue so I need to revisit this as it's also not working as expected.

            let itemDetailVC = segue.destination as! ItemAddEditViewController
            itemDetailVC.itemSelected = menuGroup?.menuItems?.first

            //        let selectedItem: MenuItems!
            //        let indexPath = collectionView.indexPathsForSelectedItems?.last?.row
            //        selectedItem = menuGroupItems![indexPath!]
            //        itemDetailVC.itemSelected = selectedItem
            //        collectionView.deselectItem(at: self.collectionView.ind , animated: true)
        }
    }
    func fetchMenuGroupItems() {
        do {
            let request = MenuItems.fetchRequest() as NSFetchRequest<MenuItems>
            self.menuGroupItems = try context.fetch(request)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("Unable to fetch menu group data")
        }
    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing == true {

            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuItem))

        } else {
            self.navigationItem.leftBarButtonItem = nil

        }
    }

    @objc func addNewMenuItem() {
        let itemAddEditViewController = self.storyboard?.instantiateViewController(withIdentifier: "itemAddEditViewController") as! ItemAddEditViewController

        itemAddEditViewController.menuGroup = menuGroup
        self.navigationController?.pushViewController(itemAddEditViewController, animated: true)
    }
}
