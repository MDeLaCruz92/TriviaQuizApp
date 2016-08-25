//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Michael De La Cruz on 8/9/16.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import GameKit
import Foundation
import AudioToolbox



class ViewController: UIViewController {
    
    let correctColor = UIColor(red: 30/255.0, green: 240/255.0, blue: 50/255.0, alpha: 1.0)
    let incorrectColor = UIColor(red: 0/255.0, green: 90/255.0, blue: 230/255.0, alpha: 1.0)

    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var questionsAskedArray: [Int] = []
    
    var counter = 15
    var timer = NSTimer()
    var timeRunner = false
    
    var gameSound: SystemSoundID = 0
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var countDown: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    
   
    
    func displayQuestion() {
    // Randomize Colors for choices
        let randomColor = ColorModel().getRandomColor()
        choice1Button.backgroundColor = randomColor
        choice2Button.backgroundColor = randomColor
        choice3Button.backgroundColor = randomColor
        choice4Button.backgroundColor = randomColor
        
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsTrivia.count)
        
        // while loop for making sure that questions are not repeated
        while questionsAskedArray.contains(indexOfSelectedQuestion) {
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questionsTrivia.count)
        }
        
        // appending global previousQuestionsArray varialbe with asked questions so that they are not repeated
        questionsAskedArray.append(indexOfSelectedQuestion)
        
        let triviaQuestions = questionsTrivia[indexOfSelectedQuestion]
        questionField.text = triviaQuestions.question
        playAgainButton.hidden = true
        
        activeButtons()
        
        // Display choice text in answer buttons
        
        choice1Button.setTitle(triviaQuestions.choice1, forState: .Normal)
        choice2Button.setTitle(triviaQuestions.choice2, forState: .Normal)
        choice3Button.setTitle(triviaQuestions.choice3, forState: .Normal)
        choice4Button.setTitle(triviaQuestions.choice4, forState: .Normal)
        
        timerReset()
        timerStart()
        
    }
    
    

    func displayScore() {
        // Hide the answer buttons
        timerReset()
        self.timeRunner = true
        choice1Button.hidden = true
        choice2Button.hidden = true
        choice3Button.hidden = true
        choice4Button.hidden = true
        countDown.hidden = true
        
        
        // Display play again button
        playAgainButton.hidden = false
        

        questionField.text = "Nice effort!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    
    // MARK: Timer Start
    
    func timerStart() {
        if timeRunner == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            
            timeRunner = true
        }
        
    }
    
    func updateCounter() {
        let questionDict = questionsTrivia[indexOfSelectedQuestion]
        let correctAnswer = questionDict.correct
        
        counter -= 1
        countDown.text = "Time Remaining: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            
            questionsAsked += 1
            questionField.text = "Ahhh, time ran out! \n The correct answer was: \(correctAnswer)"
        
            incorrectAnswerSound()
            playIncorrectSound()
            
            deactivateButtons()
            
            loadNextRoundWithDelay(seconds: 3)
        }
    }
    
    func timerReset() {
        counter = 15
        countDown.text = "Time Remaining: \(counter)"
        timeRunner = false

    }
    
    // Function to activate and deactivate the buttons so they would show whether they are needed or not
    func activeButtons() {
        choice1Button.userInteractionEnabled = true
        choice2Button.userInteractionEnabled = true
        choice3Button.userInteractionEnabled = true
        choice4Button.userInteractionEnabled = true
    }
    
    func deactivateButtons() {
        choice1Button.userInteractionEnabled = false
        choice2Button.userInteractionEnabled = false
        choice3Button.userInteractionEnabled = false
        choice4Button.userInteractionEnabled = false
    }
    
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        let questionDict = questionsTrivia[indexOfSelectedQuestion]
        let correctAnswer = questionDict.correct
        
        // added game sound and color(light green is correct & blue is incorrect) when the answer is correct or incorrect
        if sender.titleLabel!.text == correctAnswer {
            correctQuestions += 1
            questionField.text = "Correct!"
            sender.backgroundColor = correctColor
            correctAnswerSound()
            playCorrectSound()
            timer.invalidate()
        } else {
            questionField.text = "Sorry, that's not correct! The correct answer was: \(correctAnswer)"
            sender.backgroundColor = incorrectColor
            if choice1Button.titleLabel?.text == correctAnswer {
                choice1Button.backgroundColor = correctColor
                incorrectAnswerSound()
                playIncorrectSound()
                timer.invalidate()
                timerReset()
            } else if choice2Button.titleLabel?.text == correctAnswer {
                choice2Button.backgroundColor = correctColor
                incorrectAnswerSound()
                playIncorrectSound()
                timer.invalidate()
                timerReset()
            } else if choice3Button.titleLabel?.text == correctAnswer {
                choice3Button.backgroundColor = correctColor
                incorrectAnswerSound()
                playIncorrectSound()
                timer.invalidate()
                timerReset()
            } else if choice4Button.titleLabel?.text == correctAnswer {
                choice4Button.backgroundColor = correctColor
                incorrectAnswerSound()
                playIncorrectSound()
                timer.invalidate()
                timerReset()
            }
        }
        
        loadNextRoundWithDelay(seconds: 3)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        // added game sound when the game is over
            GameEndSound()
            playGameEndSound()
            timer.invalidate()
            timerReset()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        choice1Button.hidden = false
        choice2Button.hidden = false
        choice3Button.hidden = false
        choice4Button.hidden = false
        countDown.hidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        questionsAskedArray.removeAll()
        
        // added game sound to play when the game starts over again
        loadGameStartSound()
        playGameStartSound()
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            self.nextRound()
        }
    }
    
    // functions for the game sound effects
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func correctAnswerSound() {
        let correctSound = NSBundle.mainBundle().pathForResource("Clocks", ofType: "wav")
        let correctSoundURL = NSURL(fileURLWithPath: correctSound!)
        AudioServicesCreateSystemSoundID(correctSoundURL, &gameSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    func incorrectAnswerSound() {
        let incorrectSound = NSBundle.mainBundle().pathForResource("Hollowed Barrell", ofType: "wav")
        let incorrectSoundURL = NSURL(fileURLWithPath: incorrectSound!)
        AudioServicesCreateSystemSoundID(incorrectSoundURL, &gameSound)
    }
    
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func GameEndSound() {
        let gameEndSound = NSBundle.mainBundle().pathForResource("Success", ofType: "wav")
        let gameEndSoundURL = NSURL(fileURLWithPath: gameEndSound!)
        AudioServicesCreateSystemSoundID(gameEndSoundURL, &gameSound)
    }
    
    func playGameEndSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
   
    
    
    
    
    
    
    
    
    
    
}

