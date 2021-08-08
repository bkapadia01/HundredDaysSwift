//
//  TableViewController.swift
//  Project4
//
//  Created by Bhavin Kapadia on 2021-06-08.
//

import UIKit

class TableViewController: UITableViewController {
    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebsiteName", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc  = storyboard?.instantiateViewController(identifier: "browser") as? ViewController {
            vc.selectedURL = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    
}
