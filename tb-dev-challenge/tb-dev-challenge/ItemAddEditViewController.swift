//
//  ItemAddEditViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-14.
//
import CoreData
import UIKit

class ItemAddEditViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var menuItemNameTextField: UITextField!
    @IBOutlet var menuItemPriceTextField: UITextField!
    @IBOutlet var itemPriceValidationLabel: UILabel!
    @IBOutlet weak var itemImagePreview: UIImageView!
    @IBOutlet weak var deleteItemButton: UIButton!

    var menuGroup: MenuGroups?
    var imageSelected: String = ""
    var itemSelected: MenuItems?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        deleteItemButton.isHidden = true

        if itemSelected != nil {
            deleteItemButton.isHidden = false
            deleteItemButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
            menuItemNameTextField.text = itemSelected?.itemName
            menuItemPriceTextField.text = "\(itemSelected?.itemPrice ?? 0.0)"
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createNewItemForGroup))
        // MARK: Upload Button
        let imageItemUploadButton = UIButton.init(type: .system)

        imageItemUploadButton.frame = CGRect(x: 200,
                                             y: 400,
                                             width: 200,
                                             height: 60)
        imageItemUploadButton.setTitle("Upload Item Image",
                                       for: .normal)

        imageItemUploadButton.setTitleColor(.systemBlue,
                                            for: .normal)
        imageItemUploadButton.addTarget(self,
                                        action: #selector(imageItemUploadAction),
                                        for: .touchUpInside)
        self.view.addSubview(imageItemUploadButton)

        menuItemPriceTextField.delegate = self
        setupView()

    }

    @objc func deleteItem() {
        let menuItemToDelete = self.itemSelected
        self.context.delete(menuItemToDelete!)

        do {
            try self.context.save()
        } catch {
            print("Failed to save data")
        }
        _ = navigationController?.popViewController(animated: true)
    }

    @objc func createNewItemForGroup() {

        if itemSelected == nil {
            let itemName = menuItemNameTextField.text
            let itemPriceString = menuItemPriceTextField.text ?? ""
            let itemPrice = Double(itemPriceString)
            let itemImage = imageSelected

            if let addNewItem = MenuItems(itemImage: itemImage, itemName: itemName, itemPrice: itemPrice, itemDateCreated: Date()) {
                menuGroup?.addToOfMenuItem(addNewItem)

                do {
                    try addNewItem.managedObjectContext?.save()
                    _ = navigationController?.popViewController(animated: true)
                } catch {
                    print("Menu item failed to save!")
                }
            }
        } else {

            let itemName = menuItemNameTextField.text
            let itemPriceString = menuItemPriceTextField.text ?? ""
            let itemPrice = Double(itemPriceString)
            let itemImage = imageSelected
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MenuItems")

            // REVIEW: Update does not work properly, it updates the incorrect menu item in the wrong group. I plan on resolving this by understanding how fetchRequest works and image is not being update at the moment as well.
            do {
                let results = try context.fetch(fetchRequest) as? [NSManagedObject]
                results?[0].setValue(itemName, forKey: "itemName")
                results?[0].setValue(itemImage, forKey: "itemImage")
                results?[0].setValue(itemPrice, forKey: "itemPrice")
                results?[0].setValue(itemPrice, forKey: "itemPrice")

                try self.context.save()

                _ = navigationController?.popViewController(animated: true)
            } catch {
                print("Menu item failed to update!")
            }
        }

    }

    @objc func imageItemUploadAction() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ItemAddEditViewController: UITextFieldDelegate {

    func setupView() {
        // Configure Password Validation Label

        menuItemNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        menuItemPriceTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)

        itemPriceValidationLabel.isHidden = true

        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard !menuItemNameTextField.text!.isEmpty else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        guard !menuItemPriceTextField.text!.isEmpty else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }

        let priceTextField = (menuItemPriceTextField.text! as String)
        // REVIEW: Currently this takes in more than just 2 decimal places for the dollar value. I would have to possible use a another regex like validation to ensure that only dollar values are used.
        if Double(priceTextField) != nil {
            // Text field converted to an Int
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            itemPriceValidationLabel.isHidden = true
        } else {
            itemPriceValidationLabel.isHidden = false
        }

    }
}

extension ItemAddEditViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        itemImagePreview.contentMode = .scaleAspectFit
        itemImagePreview.image = chosenImage
        imageSelected = imageName
        picker.dismiss(animated: true, completion: nil)

    }

    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]

    }
}
