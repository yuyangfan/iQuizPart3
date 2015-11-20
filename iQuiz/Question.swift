//
//  Question.swift
//  iQuiz
//
//  Created by Yuyang Fan on 11/10/15.
//  Copyright © 2015 Yuyang Fan. All rights reserved.
//

import Foundation

class Question {
    var text: String = ""
    var answer: Int = -1
    var answers: [String]
    
    init(question: String, answer: Int, answers: [String]) {
        self.text = question
        self.answer = answer
        self.answers = answers
    }
}