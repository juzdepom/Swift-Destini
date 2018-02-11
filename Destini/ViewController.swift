//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Our strings
    let story1 = "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\"."
    let answer1a = "I\'ll hop in. Thanks for the help!"
    let answer1b = "Better ask him if he\'s a murderer first."
    
    
    let story2 = "He nods slowly, unphased by the question."
    let answer2a = "At least he\'s honest. I\'ll climb in."
    let answer2b = "Wait, I know how to change a tire."
    
    let story3 = "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box."
    let answer3a = "I love Elton John! Hand him the cassette tape."
    let answer3b = "It\'s him or me! You take the knife and stab him."
    
    let story4 = "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?"
    let story5 = "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in."
    let story6 = "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
    
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    var chapter: Int = 0;
    var stories: Array = [String]()
    var answers: [[Int:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stories = [story1, story2, story3, story4, story5, story6]
        answers = [
            [1:answer1a, 2:answer1b],
            [1:answer2a,2:answer2b],
            [1:answer3a,2:answer3b]
        ]
        nextChapter(tag: 0)
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        if sender.titleLabel!.text == "Start Over" {
            startOver()
            return
        }
        nextChapter(tag: Int(sender.tag))
        
    }
    
    func nextChapter(tag: Int){
        if chapter == 0 {
            storyTextView.text = stories[chapter]
            topButton.setTitle(answers[chapter][1], for: .normal)
            bottomButton.setTitle(answers[chapter][2], for: .normal)
            chapter = chapter + 1
        } else if chapter == 1 {
            //hopped in
            if tag == 1 {
                chapter = chapter + 1
                storyTextView.text = stories[2]
            //asked if murderer
            } else if tag == 2 {
                storyTextView.text = stories[1]
            }
            topButton.setTitle(answers[chapter][1], for: .normal)
            bottomButton.setTitle(answers[chapter][2], for: .normal)
            chapter = chapter + 1
        } else if chapter == 2 {
            //you decided to change the tire yourself
            if tag == 2 {
                //copped out
                storyTextView.text = stories[3]
                endStory()
            } else if tag == 1 {
                //you've gotten in the car
                storyTextView.text = stories[2]
                topButton.setTitle(answers[chapter][1], for: .normal)
                bottomButton.setTitle(answers[chapter][2], for: .normal)
                chapter = chapter + 1
            }
        } else if chapter == 3 {
            //1. love elton john. 2. stab driver
            storyTextView.text = (tag == 1) ? stories[5] : stories[4]
            endStory()
        }
    }
    
    func endStory(){
        topButton.isHidden = true
        bottomButton.setTitle("Start Over", for: .normal)
    }
    
    func startOver(){
        topButton.isHidden = false;
        chapter = 0;
        nextChapter(tag: 0)
    }
    



}

