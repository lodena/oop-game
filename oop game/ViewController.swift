//
//  ViewController.swift
//  oop game
//
//  Created by Jesus Lopez de Nava on 10/31/15.
//  Copyright © 2015 LodenaApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var gc: GameClass!
    
    var player1: Character!
    var player2: Character!
    
    var flippedImage1: Bool = false
    var flippedImage2: Bool = false
    
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var scroll: UIImageView!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    @IBOutlet weak var player1OrcButton: UIButton!
    @IBOutlet weak var player2OrcButton: UIButton!
    @IBOutlet weak var player1SoldierButton: UIButton!
    @IBOutlet weak var player2SoldierButton: UIButton!
    @IBOutlet weak var letsPlayButton: UIButton!
    @IBOutlet weak var attack1Btn: UIButton!
    @IBOutlet weak var attack2Btn: UIButton!
    @IBOutlet weak var player1name: UILabel!
    @IBOutlet weak var player1hpLabel: UILabel!
    @IBOutlet weak var player2name: UILabel!
    @IBOutlet weak var player2hpLabel: UILabel!
    @IBOutlet weak var gameNarrationLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gc = GameClass(vc: self)
        gc = GameClass()
        
        self.player1TextField.delegate = self
        self.player2TextField.delegate = self
    
    }

    @IBAction func characterSelected(sender: AnyObject) {
        
        switch sender.tag {
            
        case 1:
            displayPlayerImage(self.player1Image, imageName: "enemy", scale1: 1, scale2: 1)
            flippedImage1 = false
            
        case 2:
            displayPlayerImage(self.player1Image, imageName: "player", scale1: -1, scale2: 1)
            flippedImage1 = true
            
        case 3:
            displayPlayerImage(self.player2Image, imageName: "enemy", scale1: -1, scale2: 1)
            flippedImage2 = true
            
        case 4:
            displayPlayerImage(self.player2Image, imageName: "player", scale1: 1, scale2: 1)
            flippedImage2 = false

        default: break
            
        }
    }
    
    @IBAction func letsPlayPressed(sender: AnyObject) {
        
        if player1TextField.text == "" {
            player1TextField.text = "Player1"
        }
        
        if player2TextField.text == "" {
            player2TextField.text = "Player2"
        }
        
        player1 = Character(hp: 100, attackPower: 10, name: player1TextField.text!)
        player2 = Character(hp: 100, attackPower: 10, name: player2TextField.text!)
        
        player1name.text = player1.name
        player1hpLabel.text = "\(player1.hp) HP"
        player2name.text = player2.name
        player2hpLabel.text = "\(player2.hp) HP"
        gameNarrationLabel.text = "Prepare for Battle!!!"
        
        hideUnhideObjects()
        gc.playSound(5)
    }
    
    @IBAction func playerAttackButtonPressed(sender: AnyObject) {
        
        if sender.tag == 1 {
            attack1Btn.hidden = true
            animatePlayer(self.player1Image, image2: self.player2Image, sound: 1)
        } else {
            attack2Btn.hidden = true
            animatePlayer(self.player2Image, image2: self.player1Image, sound: 2)
        }
        
    }
    
    @IBAction func playAgainPressed(sender: AnyObject) {
        
        playAgainButton.hidden = true
        scroll.hidden = false
        player1Label.hidden = false
        player2Label.hidden = false
        player1TextField.hidden = false
        player2TextField.hidden = false
        player1OrcButton.hidden = false
        player2OrcButton.hidden = false
        player1SoldierButton.hidden = false
        player2SoldierButton.hidden = false
        letsPlayButton.hidden = false
        player1name.hidden = true
        player2name.hidden = true
        player1hpLabel.hidden = true
        player2hpLabel.hidden = true
        gameNarrationLabel.hidden = true
        player1TextField.text = ""
        player2TextField.text = ""
        
        displayPlayerImage(self.player1Image, imageName: "enemy", scale1: 1, scale2: 1)

        displayPlayerImage(self.player2Image, imageName: "player", scale1: 1, scale2: 1)
        
        flippedImage1 = false
        flippedImage2 = false
        
    }
    
    func displayPlayerImage(image: UIImageView, imageName: String, scale1: Int, scale2: Int) {
        
        image.image = UIImage(named: imageName)
        image.transform = CGAffineTransformMakeScale(CGFloat(scale1), CGFloat(scale2))
        gc.playSound(3)
    }
    
    
    func animatePlayer(image1: UIImageView, image2: UIImageView, sound: Int) {
        
        let centerX: CGFloat = image1.center.x
        
        UIView.animateWithDuration(
            0.5,
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                image1.center = CGPointMake(image2.center.x, image1.center.y)
            },
            completion: { finished in
                self.gc.playSound(sound)
                self.attackAndUpdateLabels(sound)
            }
        )
        
        UIView.animateWithDuration(
            0.5,
            delay: 0.5,
            options:.CurveEaseIn,
            animations: {
                image1.center = CGPointMake(centerX, image1.center.y)
            },
            completion: { finished in
                if sound == 1 {self.attack1Btn.hidden = false}
                else {self.attack2Btn.hidden = false}
                
                if !self.player1.isAlive {self.gameOver(2)}
                else if !self.player2.isAlive {self.gameOver(1)}
            }
        )
    }
    
    
    func attackAndUpdateLabels(player: Int) {
        
        let rand = Int(arc4random_uniform(20)) + 1
        
        if player == 1 {
            self.player1.attackPower = rand
            self.player2.gotHit(self.player1.attackPower)
            player2hpLabel.text = "\(player2.hp) HP"
            gameNarrationLabel.textColor = UIColor.blueColor()
            gameNarrationLabel.text = "\(player1.name) attacked with a force of \(player1.attackPower) points!"
        } else {
            self.player2.attackPower = rand
            self.player1.gotHit(self.player2.attackPower)
            player1hpLabel.text = "\(player1.hp) HP"
            gameNarrationLabel.textColor = UIColor.redColor()
            gameNarrationLabel.text = "\(player2.name) attacked with a force of \(player2.attackPower) points!"
        }
        
    }

    func gameOver(winner: Int) {

        if winner == 1 {
            gameNarrationLabel.text = "\(player1.name) IS THE WINNER!!!"
            player2hpLabel.text = "DEAD!!!"
            player1hpLabel.text = "WINNER!"
            
            if !flippedImage2 {
                animateDeath(player2Image, rotation: 1.55)
            } else {
                animateDeath(player2Image, rotation: -1.55)
            }
            
        } else {
            gameNarrationLabel.text = "\(player2.name) IS THE WINNER!!!"
            player1hpLabel.text = "DEAD!!!"
            player2hpLabel.text = "WINNER!"
            
            if !flippedImage1 {
                animateDeath(player1Image, rotation: -1.55)
            } else {
                animateDeath(player1Image, rotation: 1.55)
            }
    
        }
        
        gc.backgroundMusic.stop()
        gc.playSound(4)
        attack1Btn.hidden = true
        attack2Btn.hidden = true
        playAgainButton.hidden = false
    }
    
    func animateDeath(image: UIImageView, rotation: Double) {
        
        UIView.animateWithDuration(
            1,
            delay: 0,
            options: .CurveEaseIn,
            animations: {
                image.transform = CGAffineTransformMakeRotation(CGFloat(rotation))
            },
            completion: { finished in
                image.center = CGPointMake(image.center.x, image.center.y + 30)
            }
        )
    }
    
        
    func hideUnhideObjects() {
        
        self.view.endEditing(true)
        scroll.hidden = true
        player1Label.hidden = true
        player2Label.hidden = true
        player1TextField.hidden = true
        player2TextField.hidden = true
        player1OrcButton.hidden = true
        player2OrcButton.hidden = true
        player1SoldierButton.hidden = true
        player2SoldierButton.hidden = true
        letsPlayButton.hidden = true
        attack1Btn.hidden = false
        attack2Btn.hidden = false
        player1name.hidden = false
        player2name.hidden = false
        player1hpLabel.hidden = false
        player2hpLabel.hidden = false
        gameNarrationLabel.hidden = false
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

