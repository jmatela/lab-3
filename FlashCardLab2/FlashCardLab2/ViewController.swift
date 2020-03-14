//
//  ViewController.swift
//  FlashCardLab2
//
//  Created by Jenina Matela on 3/6/20.
//  Copyright © 2020 Jenina Matela. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}
class ViewController: UIViewController {
    
    @IBOutlet weak var BacklabelAnswer: UILabel!
    @IBOutlet weak var FrontlabelQuestion: UILabel!
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    //current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0 {
        UpdateFlashcard(question: "How many calories are there in a boiled egg?", answer: "76 calories")
        } else {
            updatelabels()
            updatenextprevButtons()
    }
    }
    @IBAction func DidTapOnFlashcard(_ sender: Any) {FrontlabelQuestion.isHidden = !FrontlabelQuestion.isHidden
        
    }
    
    func UpdateFlashcard(question:String, answer:String) {
        let flashcard = Flashcard (question: question, answer: answer)
        // Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        //Logging to the console
        print( "B) Added new flashcard")
        print(" B) We now have \(flashcards.count) flashcards")
        // Update current index
        currentIndex = flashcards.count - 1
        print(" B) Our current index is \(currentIndex)")
        
    
        // Update buttons
        updatenextprevButtons()
        
        // Update labels
        updatelabels()
        
        saveAllFlashcardsToDisk()
    }
    func updatelabels() {
print (currentIndex)
        let flashcard = flashcards [currentIndex]
       FrontlabelQuestion.text = flashcard.question
        BacklabelAnswer.text = flashcard.answer
    }
    func updatenextprevButtons() {
        // disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
            
        } else {
            nextButton.isEnabled = true
        }
        // Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
            
        }else {
            prevButton.isEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardscontroller = self
    }
    //do Stuff Here
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBAction func didTapOnNext(_ sender: Any) {
        //Increase current index
        currentIndex = currentIndex + 1
        updatelabels()
        updatenextprevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        //Increase current index
        currentIndex = currentIndex - 1
       
       updatelabels()
    updatenextprevButtons()
        
    }
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer] }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray,forKey: "flashcards")
        // Log it
        print (" Flashcards saved to UserDefaults")
               
}
    func readSavedFlashcards () {
        //Read dictonary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            
            // In here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!) }
                // Put all these cards in our flashcards array
                flashcards.append(contentsOf: savedCards)
            }
        
}
}
