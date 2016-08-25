//
//  Trivia.swift
//  TrueFalseStarter
//
//  Created by Michael De La Cruz on 8/18/16.
//  Copyright © 2016 Michael D. All rights reserved.
//

import UIKit
import GameKit

// used a class to declare the data set for the trivia questions and answers
class Trivia {

    let question: String
    let choice1: String
    let choice2: String
    let choice3: String
    let choice4: String
    let correct: String
    
    init(question: String, choice1: String, choice2: String, choice3: String, choice4: String, correct: String) {
        self.question = question
        self.choice1 = choice1
        self.choice2 = choice2
        self.choice3 = choice3
        self.choice4 = choice4
        self.correct = correct
    }
    
}

// Trivia questions about OOP C++
let question1 = Trivia(question: "A function that returns no values to the program that calls it is",
    choice1: "not allowed in C++",
    choice2: "type void",
    choice3: "type empty",
    choice4: "type barren",
    correct: "type void")

let question2 = Trivia(question: "Format flags may be combined using",
    choice1: "the bitwise OR operator(|)",
    choice2: "the logical OR operator(||)",
    choice3: "the bitwise AND operator(&)",
    choice4: "the logical AND operator(&&)",
    correct: "the bitwise OR operator(|)")

let question3 = Trivia(question: "The use of the break statement in a switch statement is",
    choice1: "optional",
    choice2: "compulsory",
    choice3: "It gives an error message",
    choice4: "to check an error",
    correct: "optional")


let question4 = Trivia(question: "which of the following are valid characters for a numeric literal constant?",
    choice1: "a comma",
    choice2: "a dollar sign($)",
    choice3: "a percent sign (%)",
    choice4: "None of the above",
    correct: "None of the above")

let question5 = Trivia(question: "A function that changes the state of the cout object is called a(n)",
    choice1: "member",
    choice2: "adjuster",
    choice3: "manipulator",
    choice4: "operator",
    correct: "manipulator")

let question6 = Trivia(question: "When the compiler cannot differentiate between two overloaded constructors, they are called",
    choice1: "overloaded",
    choice2: "destructed",
    choice3: "ambiguous",
    choice4: "dubious",
    correct: "ambiguous")

let question7 = Trivia(question: "the newline character is always included between",
    choice1: "pair of parentheses",
    choice2: "control string",
    choice3: "pair of curly braces",
    choice4: "&",
    correct: "control string")


let questionsTrivia = [question1,
                       question2,
                       question3,
                       question4,
                       question5,
                       question6,
                       question7]





