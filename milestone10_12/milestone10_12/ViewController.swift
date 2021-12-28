//
//  ViewController.swift
//  milestone10_12
//
//  Created by Bhavin Kapadia on 2021-12-26.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var interestsClassVar = [Interests]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Picture Notes"
        let defaults = UserDefaults.standard
        
        if let savedImages = defaults.object(forKey: "interestsClassVar") as? Data {
            if let decodeImage = try?
            NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedImages) as? [Interests] {
                interestsClassVar = decodeImage
            }
        }
//
        
        
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addImage))
//        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        let interests = interestsClassVar[indexPath.row]
        cell.textLabel?.text = interests.interestingTitle
        cell.detailTextLabel?.text = interests.interestingCaption
        return cell
    }

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {

            vc.selectedInterest = interestsClassVar[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestsClassVar.count
    }
    

    
    @objc func addImage() {
        let picker =  UIImagePickerController()
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageNameUUID = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageNameUUID)
        let imagePathString: String = imagePath.path
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        dismiss(animated: true, completion: {self.promptForCaption(imagePathString: imagePathString)})


    }

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func promptForCaption(imagePathString: String){
        let ac = UIAlertController(title: "Enter Caption", message: "Enter image caption below:", preferredStyle: .alert)
        ac.addTextField()
        
        let submit = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let caption = ac?.textFields?[0].text else { return }
            let interest = Interests(interestingTitle: "Note \(self!.interestsClassVar.count + 1)", interestingCaption: caption, interestingImagePath: imagePathString)
            self!.interestsClassVar.append(interest)
            self!.tableView.reloadData()
            self?.save()

        }
        ac.addAction(submit)
        present(ac, animated: true)

    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: interestsClassVar, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "interestsClassVar")
        }
    }


}

