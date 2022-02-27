//
//  ItemTableViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-20.
//

import UIKit

class ItemTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var menuItems = [MenuItem]()
    var menuItemsParsed = [MenuItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Add this
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "Cell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
//        navigationItem.largeTitleDisplayMode = .never
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        guard let sourcePath = Bundle.main.url(forResource: "MenuItemData", withExtension: "json") else {
            fatalError("Could not find json file")
        }
        
        if let data = try? Data(contentsOf: sourcePath) {
            parse(json: data)
            print("parsed")
        } else {
            fatalError("NOOOO")
        }
        

    }
    
    
    func parse(json: Data) -> [MenuItem]{
        let decoder = JSONDecoder()
        
        if let jsonMenuItem = try? decoder.decode([MenuItem].self, from: json) {
            menuItems = jsonMenuItem
            menuItemsParsed = menuItems
            tableView.reloadData()
        }
        return menuItemsParsed
    }

    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        
        if(self.isEditing == true) {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuItem))
            
        } else {
            self.navigationItem.leftBarButtonItem = nil

        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return menuItems.count
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ItemTableViewCell else {
            fatalError("Cell could not be dequed")
           
        }
        
        // Configure the cell...
        let menuItem = menuItems[indexPath.item]
//        cell.menuItemName.text = "heelo"
//        if let itemName = cell.menuItemName{
//            itemName.text = menuItem.itemName
//        }
//        if let itemPrice = cell.menuItemPrice{
//            itemPrice.text = menuItem.itemPrice
//            itemPrice.text = "11111"
//
//        }

//        let path = getDocumentDirectory().appendingPathComponent(menuItem.itemImage)
//        cell.menuItemImage?.image = UIImage(contentsOfFile: path.path)

//        let imgName = menuItem.itemImage
//        let imageAsset = UIImage(named: imgName)
//        if let itemImage = cell.menuItemImage {
//            itemImage.image = menuItem.itemImage
//        }
//        cell.menuItemImage.image = imageAsset
        
        self.tableView.reloadData()

        return cell
    }
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let menuItem = MenuItem(itemName: "Enter Item name", itemPrice: "1.00", itemSet: false)
        menuItems.append(menuItem)
        picker.delegate = nil

        tableView.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    @objc func addNewMenuItem() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
}
