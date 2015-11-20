//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/10/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {

    @IBOutlet weak var endText: UILabel!
    @IBOutlet weak var score: UILabel!
    
    var questionIndex : Int = 0
    var totalScore : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        
        score.text = "\(totalScore) out of \(questionIndex) are correct!"
        
        let scorePercent : Double = Double(totalScore) / Double(questionIndex)
        if(scorePercent == 1) {
            endText.text = "Perfect! :)"
        }else if (scorePercent > 0.7 ){
            endText.text = "Great Job! :)"
        }else if (scorePercent > 0.5){
            endText.text = "Not Bad! :)"
        }else{
            endText.text = "Fail! :("
        }
    }

    func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func next(sender: AnyObject) {
        self.performSegueWithIdentifier("showQuiz", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
