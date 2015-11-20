//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/10/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var result: UILabel!
    
    var quiz : Quiz = Quiz(title: "", desc: "", questions: [])
    var selectedChoice : Int = -1
    var score : Int = 0
    var questionIndex : Int = 0
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        questionLabel.text = quiz.questions[questionIndex].text
        let rightAnswer = quiz.questions[questionIndex].answer
        correctAnswer.text = "Correct Answer is: \(quiz.questions[questionIndex].answers[rightAnswer - 1])"
       // let myAnswer = quiz.questions[questionIndex].answers[selectedChoice]
        
        if (selectedChoice == Int(rightAnswer)) {
            result.text = "Correct!"
            score++
        }else {
            result.text = "Incorrect!"
        }
        questionIndex++
        
    }

    
    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func NextQuestion(sender: AnyObject) {
        if (quiz.questions.count == questionIndex) {
            self.performSegueWithIdentifier("showFinished", sender: self)
        }else {
            self.performSegueWithIdentifier("showNext", sender: self)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (quiz.questions.count > questionIndex){
            let controller = segue.destinationViewController as! QuestionViewController
            controller.questionIndex = questionIndex
            controller.score = score
            controller.quiz = quiz
        }else {
            let controller = segue.destinationViewController as! FinishedViewController
            controller.totalScore = score
            controller.questionIndex = questionIndex
        }
    }


}
