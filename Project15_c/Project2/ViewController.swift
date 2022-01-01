//
//  ViewController.swift
//  Project2
//
//  Created by Bhavin Kapadia on 2021-05-16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var count = 0
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain" ,"uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " - Score: " + String(score)
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: []) {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
         } completion: { void in ()
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
         }
    
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            count += 1
        } else {
            title = "Wrong"
            score -= 1
            count += 1
        }
       
        if(sender.tag != correctAnswer) {
            let ac = UIAlertController(title: title, message: "You selected the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: title, style: .default, handler: nil))
            present(ac, animated: true)
        }
        
        
        if((count % 10) == 0) {
            let ac = UIAlertController(title: title, message: "You're score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: title, style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            askQuestion()
        }
        
    }
    
    @objc func showScore() {
        
            let ac = UIAlertController(title: "Score", message: "You're score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        
    }
    
}

