//
//  ViewController.swift
//  milestone4_6
//
//  Created by Bhavin Kapadia on 2021-06-20.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
        
        newList()

     
    }

    @objc func addToList() {
        let ac = UIAlertController(title: "Add Item:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let addItemAction = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let addItem = ac?.textFields?[0].text else { return }
            self?.submit(addItem)
        }
        ac.addAction(addItemAction)
        present(ac, animated: true)
        
    }
    
    func newList() {
        title = "Shopping List"
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    @objc func refreshList() {
        shoppingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    
    @objc func submit(_ addItem: String) {
        shoppingList.insert(addItem, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }

}

