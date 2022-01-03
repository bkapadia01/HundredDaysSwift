//
//  ViewController.swift
//  milestone13_15
//
//  Created by Bhavin Kapadia on 2022-01-01.
//

import UIKit

var countries = ["1"]
var countryFact = [CountryFact]()
var countryFactParsed = [CountryFact]()


class ViewController: UITableViewController & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Country Facts"

        guard let sourcePath = Bundle.main.url(forResource: "CountryData", withExtension: "json") else {
            fatalError("Could not find json file")
        }
       
        if let data = try? Data(contentsOf: sourcePath) {
            parse(json: data)
        } else {
            fatalError("NOOOO")
        }
        
        
    }
    
    func parse(json: Data) -> [CountryFact]{
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode([CountryFact].self, from: json) {
            countryFact = jsonPetitions
            countryFactParsed = countryFact
            tableView.reloadData()
        }
        return countryFactParsed
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryFactParsed.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let countryName = countryFactParsed[indexPath.row]
        cell.textLabel?.text = countryName.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItems = countryFactParsed[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
