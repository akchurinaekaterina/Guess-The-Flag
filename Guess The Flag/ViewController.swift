//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Ekaterina Akchurina on 17.09.2020.
//  Copyright © 2020 Ekaterina Akchurina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            score += 1
            showAlert(title: "Correct!", messag: "Your score is \(score)")
        } else {
            score -= 1
            showAlert(title: "Ooops!", messag: "This is \(countries[correctAnswer].uppercased()). Now your score is \(score)")
        }
        print(score)
    }
    
    
    var countries = [String]()
    var buttons = [UIButton]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        buttons += [button1, button2, button3]
        
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        
        
        askQuestions()
        
        

    }
    
    func askQuestions(_: UIAlertAction! = nil) {
        
        countries.shuffle()
        
        for button in buttons {
            guard let index = buttons.firstIndex(of: button) else {return}
            button.setImage(UIImage(named: countries[index]), for: .normal)
        }
        
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
        
    }
    
    func showAlert (title: String, messag: String) {
        let alert = UIAlertController(title: title, message: messag, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestions))
        present(alert, animated: true)
        
    }


}

