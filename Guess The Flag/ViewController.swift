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
    
    var highScore = 0
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            score += 1
            showAlert(title: "Correct!", messag: "Your score has +1")
        } else {
            score -= 1
            showAlert(title: "Ooops!", messag: "This is \(countries[correctAnswer].uppercased()). Now your score has -1")
        }
    }
    
    
    var countries = [String]()
    var buttons = [UIButton]()
    var score = 0
    var correctAnswer = 0
    
    var questionsAsked = 0 {
        didSet {
            if questionsAsked == 11 {
                let finishAlert = UIAlertController(title: "FINISH", message: "You have answered 10 questions, your score is \(score)", preferredStyle: .alert)
                finishAlert.addAction(UIAlertAction(title: "RESET", style: .default, handler: { (UIAlertAction) in
                    self.checkHighScore(for: self.score)
                    self.questionsAsked = 0
                    self.score = 0
                    self.askQuestions()
                }))
                present(finishAlert, animated: true)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        buttons += [button1, button2, button3]
        
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(showScore))
        
        
        loadHighScore()
        askQuestions()
        
        

    }
    @objc func showScore() {
        let scoreController = UIAlertController(title: "PAUSE", message: "Your score is \(score), you have answered \(questionsAsked - 1) of 10 questions.", preferredStyle: .alert)
        scoreController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(scoreController, animated: true, completion: nil)
        
    }
    
    func askQuestions(_: UIAlertAction! = nil) {
        countries.shuffle()
        
        for button in buttons {
            guard let index = buttons.firstIndex(of: button) else {return}
            button.setImage(UIImage(named: countries[index]), for: .normal)
        }
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())"
        
        
        questionsAsked += 1

        
    }
    
    func showAlert (title: String, messag: String) {
        let alert = UIAlertController(title: title, message: messag, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestions))
        present(alert, animated: true)
        
    }
    
    func loadHighScore(){
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let savedScore = defaults.data(forKey: "highscore") {
            guard let decodedScore = try? decoder.decode(Int.self, from: savedScore) else {fatalError("Unable to load highscore")}
            highScore = decodedScore
        } else {
            highScore = 0
        }
    }
    func saveHighScore(_ score: Int){
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        guard let savedScore = try? encoder.encode(score) else {fatalError("unable to save highscore")}
        defaults.set(savedScore, forKey: "highscore")
    }
    func checkHighScore(for score: Int){
        if score > highScore {
            saveHighScore(score)
            let highScAlert = UIAlertController(title: "Congratulations!", message: "Yoh have a highscore", preferredStyle: .alert)
            highScAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(highScAlert, animated: true, completion: nil)
        }
    }


}

