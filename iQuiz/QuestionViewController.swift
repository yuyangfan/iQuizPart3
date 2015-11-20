//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/10/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var quiz : Quiz = Quiz(title: "", desc: "", questions: [])
    var questionIndex : Int = 0
    var selectedIndex : Int = 0
    
    var selectedChoice : Int = -1
    var score : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        questionLabel.text = quiz.questions[questionIndex].text
        
        
    }
    
    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! AnswerViewController
        controller.quiz = quiz
        controller.questionIndex = questionIndex
        controller.score = score
        controller.selectedChoice = selectedChoice
        
    }
    
    
    

    @IBAction func submitAnswer(sender: UIButton) {
        self.performSegueWithIdentifier("showAnswer", sender: nil)
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "QuizTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! QuizTableViewCell
        
        //
        let answer = quiz.questions[questionIndex].answers[indexPath.row]
        cell.nameLabel.text = answer
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var first = quiz.questions[questionIndex].answers[indexPath.row]
        var second = quiz.questions[questionIndex].answers[selectedIndex]
        while(first != second) {
            selectedIndex = selectedIndex + 1
            first = quiz.questions[questionIndex].answers[indexPath.row]
            second = quiz.questions[questionIndex].answers[selectedIndex]
        }
        self.selectedChoice = self.selectedIndex + 1
        
    }

}
