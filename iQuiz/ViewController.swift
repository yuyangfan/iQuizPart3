//
//  ViewController.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/3/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    var newQuiz = [AnyObject]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.urlTextField.text = "http://tednewardsandbox.site44.com/questions.json"
        self.urlTextField.clearButtonMode = .Always
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadNewQuestions(sender: AnyObject) {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        // Create session and optionally set a NSURLSessionDelegate
        let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let URL = NSURL(string: self.urlTextField.text!)
        
        let request = NSMutableURLRequest(URL: URL!)
        request.HTTPMethod = "GET"
        
        // Start a new task
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            //Success
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            
            print("URL Session Task Succeeded: HTTP \(statusCode)")
            
            do {
                self.newQuiz = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]
                //print(self.newQuiz)
                //print("test")
                //print(self.newQuiz[0]["title"], self.newQuiz[0]["desc"])
                //let newQuestion = self.newQuiz[0]["questions"] as! [AnyObject]
                
                
                //print(newQuestion)
                
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject(self.newQuiz, forKey: "storedQuiz")
                
                
                
                
                
            }catch{
                //report errorx
            }
        }
         task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goBack" {
            let controller = segue.destinationViewController as! QuizTableViewController
            controller.newQuiz = self.newQuiz as [AnyObject]
        }
    }

}

