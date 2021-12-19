//
//  ViewController.swift
//  project5
//
//  Created by Bhavin Kapadia on 2021-06-09.
//

import UIKit

class ViewController: UITableViewController {
    
    let defaults = UserDefaults.standard
    
    var allWords = [String]()
    var usedWords = [String]()
    
    var savedUsedWords = [String]()
    var currentWordInPlay = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(replayGame))
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty{
                allWords = ["silkworm"]
            }
//        startGame()
        // set key for usedwords and current
        savedUsedWords = defaults.object(forKey: "SavedUsedWords") as? [String] ?? [String]()
        currentWordInPlay = defaults.object(forKey: "CurrentPlayWord") as? String ?? String()
        usedWords = savedUsedWords
        title = currentWordInPlay
    }

    func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        defaults.set(usedWords, forKey: "SavedUsedWords")

        defaults.set(title, forKey: "CurrentPlayWord")
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        // review clousre weak below .. closure's capture list comes before its parameters.
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)

        present(ac, animated: true)

    }
    
    @objc func replayGame() {
        startGame()
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        let errorTitle: String
        let errorMessage: String
        
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    if isStartWord(word: lowerAnswer){
                        if isTooShort(word: lowerAnswer){
                            usedWords.insert(answer, at: 0)
                    
                            let indexPath = IndexPath(row: 0, section: 0)
                            tableView.insertRows(at: [indexPath], with: .automatic)
                            
                            savedUsedWords = usedWords
                            defaults.set(savedUsedWords, forKey: "SavedUsedWords")
                            print(savedUsedWords)
                            return
                            } else {
                            showErrorMessage(errorTitle: "Word is too short", errorMessage: "Enter word greater than 3 characters")
                            }
                    }
                    else {
                        showErrorMessage(errorTitle: "Word can not be same as start word", errorMessage: "You can't do that")
                    }
                } else {
                    showErrorMessage(errorTitle: "Word not recognized", errorMessage: "Can't make up a word")
                }
            } else {
                showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original")
            }
        } else {
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "Can't spell that world from \(title!.lowercased())")
        }
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
  
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {return false }
        
        for letter in word {
            if let positon = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: positon)
                } else {
                    return false
                }
            }
        return true
    }

    func isOriginal(word: String) -> Bool {
        let usedWordsLowerCased = usedWords.map {
            $0.lowercased()
        }
        return !usedWordsLowerCased.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func isStartWord(word: String) -> Bool {
        return !(title == word)
    }
    
    func isTooShort(word: String) -> Bool {
        return !(word.count < 3)
    }
}

