//
//  ViewController.swift
//  BullsEye
//
//  Created by Melvin Asare  on 01/02/2019.
//  Copyright © 2019 Melvin Asare . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var roundCounter = 0
    
    @IBOutlet weak var round: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var userTarget: UILabel!
    @IBAction func hitMeButton(_ sender: UIButton) {
        alertAppear()
    }
    
    @IBAction func startGameOver(_ sender: UIButton) {
        startGameOverClicked()
        updateLabels()
    }
    
    func startGameOverClicked() {
        roundCounter = 0
        score = 0
        startNewRound()
    }
    
    func alertAppear() {
        var difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 10 {
            title = "You're pretty close"
        } else if difference < 20 {
            title = "Unlcuky"
        } else {
            title = "Not even close!"
        }
        
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
            self.updateLabels()
        })
        
        if currentValue > targetValue {
            difference = currentValue - targetValue
        } else if targetValue > currentValue {
            difference = targetValue - currentValue
        } else {
            difference = 0
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        print("The value of the slider is \(slider.value)")
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    @IBOutlet weak var scoreNumber: UILabel!
    
    func startNewRound() {
        roundCounter += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        userTarget.text = String(targetValue)
        scoreLabel.text = String(score)
        round.text = String(roundCounter)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGameOverClicked()
        updateLabels()
    }
}
