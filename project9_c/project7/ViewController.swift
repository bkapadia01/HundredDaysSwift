//
//  ViewController.swift
//  project7
//
//  Created by Bhavin Kapadia on 2021-06-20.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetition = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.organize, target: self, action: #selector(showCredits))
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:.edit, target: self, action: #selector(filterResults))
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            } else {
                showError()
            }
        } else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was an error", preferredStyle:.alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) -> [Petition]{
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetition = petitions
            tableView.reloadData()
        }
        return filteredPetition
    }

    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "Resource comes from \n \"We The People API\"", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filterResults() {
        let ac = UIAlertController(title: "Filter", message: "Filter for: ", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let filter = ac?.textFields?[0].text else { return }
            self?.submit(filter)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ filter: String) -> [Petition] {
     
        if filter.isEmpty {
             showErrorMessage(errorTitle: "No filter entered", errorMessage: "Please enter a string to filter results by")
        } else {
            filteredPetition = petitions.filter {
                  $0.title.contains(filter)
            }
        }
        tableView.reloadData()
        return filteredPetition
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetition.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetition[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
