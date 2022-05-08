//
//  MenuGroupViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-19.
//

import UIKit
import CoreData

class MenuGroupViewController: UICollectionViewController, UINavigationControllerDelegate {
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var menuGroupData: [MenuGroups]?
    var editModeEnabled: Bool = false
    private var action: UIAlertAction!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewMenuGroup))
        self.navigationItem.rightBarButtonItem = editButtonItem
        editButtonItem.isEnabled = false
        fetchMenuGroup()

        if self.menuGroupData?.count ?? 0 > 0 {
            editButtonItem.isEnabled = true
        }
    }

    func fetchMenuGroup() {
        do {
            self.menuGroupData = try context.fetch(MenuGroups.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            print("Unable to fetch menu group data")
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuGroupData?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuGroup", for: indexPath) as? MenuGroupCell else {
            fatalError("MenuGroupCell could not be dequed")
        }

        guard let menuGroupFromData = self.menuGroupData?[indexPath.item] else {
            fatalError("Data for the cell for item at menu group could not be retrieved")
        }

        cell.menuGroupName.text = menuGroupFromData.menuName
        let menuImageName = menuGroupFromData.menuImage
        let imageAsset = UIImage(named: menuImageName ?? "")

        let path = getDocumentDirectory().appendingPathComponent(menuGroupFromData.menuImage ?? "")
        cell.imageView.image = UIImage(contentsOfFile: path.path) ?? imageAsset
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let menuGroupFromData = self.menuGroupData?[indexPath.item] else {
            print("Data for the selected menu group could not be retrieved")
            return
        }

        if menuGroupFromData.menuSet == true && editModeEnabled == true {
            editMenu(indexPath: indexPath)
        } else if menuGroupFromData.menuSet == true && editModeEnabled == false {
            self.performSegue(withIdentifier: "ItemCollectionViewSegue", sender: indexPath)
            return
        }
        if menuGroupFromData.menuSet == false {
            renameMenu(indexPath: indexPath)
        }
    }
}

extension MenuGroupViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let menuItemCollectionVC = segue.destination as? ItemCollectionViewController,
              let selectedItem = self.collectionView.indexPathsForSelectedItems?.last?.row else {
            return
        }
        menuItemCollectionVC.menuGroup = menuGroupData?[selectedItem]
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)

        if editing {
            editModeEnabled = true
        } else {
            editModeEnabled = false
        }
    }

    func renameMenu(indexPath: IndexPath) {
        guard let menuGroup = self.menuGroupData?[indexPath.row] else {
            print("Data for the selected menu group could not be retrieved")
            return
        }
        
        let ac = UIAlertController(title: "Rename Menu Group", message: nil, preferredStyle: .alert)
        ac.addTextField {
            (textField) in
            textField.placeholder = "Menu Group Name"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }

        action = UIAlertAction(title: "Add", style: .default) {   [weak self, weak ac] _ in
            guard let newMenuGroupName = ac?.textFields?[0].text else { return }
            menuGroup.menuName = newMenuGroupName
            menuGroup.menuSet = true
            do {
                try self?.context.save()
            } catch {
                print("Failed to save data")
            }
            self?.fetchMenuGroup()

        }
        action.isEnabled = false
        ac.addAction(action)

        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)

    }

    @objc private func textFieldDidChange(_ field: UITextField) {
        action.isEnabled = field.text?.count ?? 0 > 0
    }

    func deleteMenu(indexPath: IndexPath) {
        guard let menuGroupDataToRemove = self.menuGroupData?[indexPath.item] else {
            print("Could not retrive data to delete for selected menu group")
            return
        }
        self.context.delete(menuGroupDataToRemove)

        do {
            try self.context.save()
        } catch {
            print("Failed to save data")
        }
        fetchMenuGroup()

        if self.menuGroupData?.count ?? 0 < 1 {
            editButtonItem.isEnabled = false
            setEditing(false, animated: true)
        }
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

extension MenuGroupViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)

        let newMenuGroup = MenuGroups(context: self.context)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        newMenuGroup.menuName = "Click to set name"
        newMenuGroup.menuImage = imageName
        newMenuGroup.menuSet = false

        editButtonItem.isEnabled = true
        dismiss(animated: true)

        // save the data
        do {
            try self.context.save()
        } catch {
            print("Failed to save data")
        }
        self.fetchMenuGroup()
    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]

    }
}
