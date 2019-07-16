//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0 // keeping the state of which question the user is on
    var score : Int = 0 // keeping track of the score
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstQuestion = allQuestions.list[0]
//        questionLabel.text = firstQuestion.questionText
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        // we can check which button was pressed
        // we use one = for assignment and == for checking equality
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        // now check if the answer picked is correct--so check the answer!
        checkAnswer()
        questionNumber = questionNumber + 1 // increments to the next question
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
      
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI() // this one will update the score on the UI
        }
        else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver() // this is a closure. We are using a method in this same file and so we use "self" . When we see the word "in" we will need "self" b/c we are inside a closure
            }
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
    }
    }
    
    func checkAnswer() {
        // need to check the picked answer with the actual answer
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
       questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
