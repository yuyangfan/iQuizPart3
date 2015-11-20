//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/3/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    
    // MARK: Properties
    
    
    var quizes : [Quiz] = []
    var newQuiz = [AnyObject]()
    
    @IBAction func Setting(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated:true, completion:nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       
        
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let storedQuiz = defaults.arrayForKey("storedQuiz")
        if (storedQuiz != nil) {
            quizes = parseJSONFile(storedQuiz!)
            self.tableView.reloadData()
        }

        
//        var question1 = Question(question: "100 + 30 = ?", answer: 1, answers:["130", "150", "160", "200"])
//        var question2 = Question(question: "100 * 30 = ?", answer: 2, answers:["1300", "3000", "2600", "30000"])
//        var question3 = Question(question: "100 / 20 = ?", answer: 3, answers:["50", "100", "5", "15"])
//        var question4 = Question(question: "100 - 98 = ?", answer: 3, answers:["13", "6", "2", "75"])
//        
//        let mathQuiz = Quiz(title: "Mathematics", desc: "Test your math skills", questions: [question1, question2, question3, question4])
//        
//        question1 = Question(question: "How many heros are there in Fantasy 4?", answer: 1, answers:["4", "2", "14", "44"])
//        question2 = Question(question: "Who is Iron Man?", answer: 1, answers:["Tony Stark", "Jimmy Stark", "Josh Stark", "Mad Stark"])
//        question3 = Question(question: "Who is not an avenger?", answer: 2, answers:["Iron Man", "Batman", "Hulk", "Thor"])
//        question4 = Question(question: "Who is the oldest avenger?", answer: 3, answers:["Iron Man", "Hulk", "Thor", "Captain America"])
//        
//        let marvelQuiz = Quiz(title: "Marvel Super Heros", desc: "How well do you know about it", questions: [question1, question2, question3, question4])
//        
//        question1 = Question(question: "Which one is the intro class to Science?", answer: 1, answers:["Science 101", "Science 498", "Science 200", "Science 191"])
//        question2 = Question(question: "Which class teaches you gravity", answer: 4, answers:["Math", "English", "Chemstry", "Physics"])
//        question3 = Question(question: "What is the percentage of Oxygen in the air?", answer: 1, answers:["21%", "82%", "0.2%", "36%"])
//        question4 = Question(question: "What is the average gravity on earth?", answer: 2, answers:["12.8", "9.8", "11.8", "10.8"])
//        
//        let scienceQuiz = Quiz(title: "Science", desc: "All about natural science", questions: [question1, question2, question3, question4])
//        
//        quizes = [mathQuiz, marvelQuiz, scienceQuiz]
        
        
        
        self.navigationItem.title = "Choose A Quiz"
       
        
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quizes.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "QuizTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! QuizTableViewCell
        
        cell.nameLabel.text = quizes[indexPath.row].title
        switch cell.nameLabel.text! {
            case "Mathematics":
                cell.photoImageView.image = UIImage(named: "math")
        
            case "Marvel Super Heros":
                cell.photoImageView.image = UIImage(named: "marvel")
            
            case "Science":
                cell.photoImageView.image = UIImage(named: "science")
            
            default:
                cell.photoImageView.image = UIImage(named: "default")
        }
        
         cell.descriptions.text = quizes[indexPath.row].desc

        return cell
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showQuestion" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let quiz = quizes[indexPath.row]
                let controller = segue.destinationViewController as! QuestionViewController
                controller.quiz = quiz 
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
                controller.navigationItem.title = quiz.title
            }
        }

    }

    
    @IBAction func goBack(segue: UIStoryboardSegue) {
        print("Unwind Back!")
        quizes = parseJSONFile(newQuiz)
        self.tableView.reloadData()
        
        
    }
    
    func parseJSONFile(newQuiz: [AnyObject]) -> [Quiz]{
        var myQuizes = [Quiz]()
        
        // Read through newQuiz, create Quiz object
        for quiz in newQuiz {
            let title = quiz["title"] as! NSString
            let desc = quiz["desc"] as! NSString
            let questions = quiz["questions"] as! [AnyObject]
            
            let myQuiz = Quiz(title:"", desc:"", questions: [])
            myQuiz.title = title as String
            myQuiz.desc = desc as String
            //print(myQuiz.title, myQuiz.desc)
            
            // Read through each Quiz, create Question object
            for question in questions {
                let answer = question["answer"] as! NSString
                let answers = question["answers"] as! [NSString]
                let text = question["text"] as! NSString
                
                let newQuestion = Question(question: text as String, answer: Int(answer as String)!, answers: answers as! [String])
                
                myQuiz.questions.append(newQuestion)
                
            }
            
            myQuizes.append(myQuiz)
            
        }
        
        //print(myQuizes[0].title,myQuizes[1].title,myQuizes[2].title)
        
        return myQuizes
    }
    

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    

}
