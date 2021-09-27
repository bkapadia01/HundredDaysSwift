//
//  ViewController.swift
//  milestone7_9
//
//  Created by Bhavin Kapadia on 2021-09-06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageHangman: UIImage!
    var wordLabel: UILabel!
    var wordSelectionList = [String]()
    var wordToGuess = String()
    var letterEntered: UILabel!
    var enterLetter: UIButton!
    var listOfLettersEntered = [String]()
    var wordInPlay = String()
    var countOfMissedLetter = 0
    var updateCountOfMissedLetter = 0
    var bodyParts = 0
    var imageName = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = UIView()
        view.backgroundColor = .white
 
        imageOfHangman(imageFile: "4.jpg")
        
        performSelector(inBackground: #selector(loadWord), with: nil)
        
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.text = wordInPlay
        wordLabel.font = UIFont.systemFont(ofSize: 50)
        view.addSubview(wordLabel)
        
        letterEntered = UILabel()
        letterEntered.translatesAutoresizingMaskIntoConstraints = false
        letterEntered.textAlignment = .center
        letterEntered.text = "- - - - - - - "
        letterEntered.font = UIFont.systemFont(ofSize: 44)
        letterEntered.textColor = .blue
        view.addSubview(letterEntered)
        
        enterLetter = UIButton(type: .roundedRect)
        enterLetter.translatesAutoresizingMaskIntoConstraints = false
        enterLetter.setTitle("Enter Letter", for: .normal)
        enterLetter.titleLabel?.sizeToFit()
        enterLetter.titleLabel?.font = UIFont.systemFont(ofSize: 33)
        enterLetter.layer.borderWidth = 3
        enterLetter.layer.borderColor = UIColor.gray.cgColor
        enterLetter.addTarget(self, action: #selector(enterLetterButtonTapped), for: .touchUpInside)
        view.addSubview(enterLetter)
        
        
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            wordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            letterEntered.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            letterEntered.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 100),
            enterLetter.topAnchor.constraint(equalTo: wordLabel.bottomAnchor, constant: 30),
            enterLetter.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ])
    }
    
    @objc func loadWord() {
        if let wordURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let word = try? String(contentsOf: wordURL) {
                wordSelectionList = word.components(separatedBy: "\n").dropLast().shuffled()
                wordToGuess = wordSelectionList.first!
                print(wordToGuess)
                for _ in wordToGuess {
                        wordInPlay += "?"
                }
                
            }
        }
        
        else {
            showErrorMessage(errorTitle: "ERROR", errorMessage: "Failed to load a word")
        }
    }
    
    func updateLabel() {
        wordLabel.text = wordInPlay
    }
    
    func refreshListOfEnteredLetter() {
        countOfMissedLetter = 0
        updateCountOfMissedLetter = 0
        bodyParts = 0
        letterEntered.text = "- - - - - - - "
        listOfLettersEntered = [""]
    }

    @objc func enterLetterButtonTapped() {
        let ac = UIAlertController(title: "Enter a character", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {_ in
            guard let answer = ac.textFields?[0].text else { return }
            self.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func startNewGame() {
        wordInPlay = ""
        listOfLettersEntered = [""]
        wordSelectionList = wordSelectionList.shuffled()
        wordToGuess = wordSelectionList.first!
        print(wordToGuess)
        for _ in wordToGuess {
                wordInPlay += "?"
        }
        updateLabel()
        refreshListOfEnteredLetter()
        imageOfHangman(imageFile: "4.jpg")
    }
    
    func submit(_ inputLetter: String) {
        let uppercaseInputAnswer = inputLetter.uppercased()
        
        if uppercaseInputAnswer.count > 1 {
            showErrorMessage(errorTitle: "ERROR", errorMessage: "Enter only 1 Character")
        } else if uppercaseInputAnswer.count == 0 {
            showErrorMessage(errorTitle: "ERROR", errorMessage: "Field is empty, please enter a character")
        } else if listOfLettersEntered.contains(uppercaseInputAnswer) {
            showErrorMessage(errorTitle: "ERROR", errorMessage: "Letter has already been used")
        } else {
            listOfLettersEntered.append(uppercaseInputAnswer)
            letterEntered.text = listOfLettersEntered.joined(separator: " ")
            updateWordInPlay()
            countBodyParts()
        }
    }

    
    func imageOfHangman(imageFile: String) {
        imageName = "\(imageFile).jpg"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 325, y: 500, width: 400, height: 600)
        view.addSubview(imageView)
        print("Body part count: \(bodyParts)")
    }
    
    
    func countBodyParts() {
        let intialCount = wordToGuess.count
        countQuestionMarks()
        if(countOfMissedLetter == intialCount) {
            bodyParts += 1
        } else if (countOfMissedLetter == updateCountOfMissedLetter) {
            bodyParts += 1
        } else {
            print("pheww saveddd")
            updateCountOfMissedLetter = countOfMissedLetter
        }
        
        if (bodyParts == 6){
            print("YOU LOSE")
            showGameDoneMessage(ggTitle: "YOU LOSE", ggMessage: "YOU KILLED HANGMAN")
        }
        
        if(countOfMissedLetter == 0) {
            print("DONE")
            showGameDoneMessage(ggTitle: "YOU WIN", ggMessage: "YOU SAVED HANGMAN!")
        }
        imageOfHangman(imageFile: "\(bodyParts + 4).jpg")
    }
    
    func updateWordInPlay() {
        var runningWord = ""
        for letter in wordToGuess { //B
            var letterWeAreAddingToRunningWord = ""
            for input in listOfLettersEntered { // each input
                let strLetter = String(letter)
                if strLetter == input {
                    letterWeAreAddingToRunningWord = strLetter
                    break
                } else {
                    letterWeAreAddingToRunningWord = "?"
                }
            }
            runningWord += letterWeAreAddingToRunningWord
        }
        wordLabel.text = runningWord
    }

    func countQuestionMarks() {
        countOfMissedLetter = 0
        for question in wordLabel.text! {
            if(question == "?") {
                countOfMissedLetter += 1
            }
        }
    }

    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.enterLetterButtonTapped()
        }))
        present(ac, animated: true)
    }
    
    func showGameDoneMessage(ggTitle: String, ggMessage: String) {
        let ac = UIAlertController(title: ggTitle, message: ggMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "START NEW GAME", style: .default, handler: { (action) in
            self.startNewGame()
        }))
        present(ac, animated: true)
    }

}

