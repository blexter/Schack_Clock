//
//  ViewController.swift
//  SchackClock
//
//  Created by Andreas Selguson on 2024-03-17.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    @IBOutlet weak var player1Button: UIButton!
    @IBOutlet weak var player2Button: UIButton!
    @IBAction func player1Button(_ sender: Any) {
        player1Button.setTitle("Player 1 - Playing!", for: .normal)
        player2Button.setTitle("Player 2", for: .normal)
        activePlayer = 1
        restartTimer()
    }
    @IBAction func player2Button(_ sender: Any) {
        player2Button.setTitle("Player 2 - Playing!", for: .normal)
        player1Button.setTitle("Player 1", for: .normal)
        activePlayer = 2
        restartTimer()
    }
    var timer : Timer?
    var activePlayer = 0
    
    var gameTime : TimeInterval = 0.1 * 60
    
    var player1gameTime : TimeInterval = 0
    var player2gameTime : TimeInterval = 0
    let oneSecond: TimeInterval = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player1gameTime = gameTime
        player2gameTime = gameTime
        
        
    }
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.updateTimeLabel(player : self.activePlayer, timer : timer)
            
        }
    }
    func restartTimer() {
            timer?.invalidate()
            startTimer()
        }
        
        func updateTimeLabel(player : Int, timer : Timer){
            if player == 1 {
                player1gameTime -= oneSecond
                player1Label.text = formatTime(timeInterval: player1gameTime)
                if(player1gameTime == 0){
                    player1Button.setTitle("Player 1", for: .normal)
                    player1Button.isEnabled = false
                    player2Button.isEnabled = false
                    player1Label.text = "Game Over!"
                    player2Label.text = ""
                    timer.invalidate()
                }
            }
            else if player == 2 {
                player2gameTime -= oneSecond
                player2Label.text = formatTime(timeInterval: player2gameTime)
                if(player2gameTime == 0){
                    player2Button.setTitle("Player 2", for: .normal)
                    player1Button.isEnabled = false
                    player2Button.isEnabled = false
                    player1Label.text = ""
                    player2Label.text = "Game Over!"
                    timer.invalidate()
                }
            }
        }
        
        func formatTime(timeInterval: TimeInterval) -> String {
            let minutes = Int(timeInterval / 60)
            let seconds = Int(timeInterval) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    
        deinit{
            timer?.invalidate()
        }
}
    

