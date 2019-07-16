//
//  Question.swift
//  Quizzler
//
//  Created by Sandi Ma on 6/28/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    // this below is a constant, but also a property of this Question class
    
    let questionText : String
    let answer: Bool
    
    // we need to initialize these properties, but this will need arguments (ex: Questions(arg, arg) 
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
}
