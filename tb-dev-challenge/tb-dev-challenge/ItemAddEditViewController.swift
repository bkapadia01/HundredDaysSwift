//
//  ItemAddEditViewController.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-14.
//

import UIKit

class ItemAddEditViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var menuItemNameTextField: UITextField!
    @IBOutlet var menuItemPriceTextField: UITextField!
    @IBOutlet var itemPriceValidationLabel: UILabel!
    @IBOutlet weak var itemImagePreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createNewItemForGroup))
        // Mark: Upload Button
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

//        imageItemUpload.addTarget(self, action: #selector(imageItemUploadAction), for: .touchUpInside)
        setupView()
        
     
    }
    
    @objc func createNewItemForGroup() {
        
        _ = navigationController?.popViewController(animated: true)
        
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
        if Int(priceTextField) != nil {
                   // Text field converted to an Int
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            itemPriceValidationLabel.isHidden = true
        } else {
            itemPriceValidationLabel.isHidden = false
        }

    }
}

extension ItemAddEditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        itemImagePreview.contentMode = .scaleAspectFit
        itemImagePreview.image = chosenImage
        picker.dismiss(animated: true, completion: nil)


    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
}
