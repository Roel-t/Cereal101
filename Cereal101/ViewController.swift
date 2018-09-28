//
//  ViewController.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox



class ViewController: UIViewController {
    

    @IBOutlet weak var milk: UIImageView!
    @IBOutlet weak var cerealBox: UIImageView!
    
    @IBOutlet weak var HowToLabel: UILabel!
    @IBOutlet weak var LearnNowButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()

    
    @IBAction func LearnButton(_ sender: Any) {
        
        audioPlayer.setVolume(0.03, fadeDuration: 1.5)
        audioPlayer.numberOfLoops = 10
        AudioServicesPlaySystemSound (1104)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LearnNowButton.layer.cornerRadius = 4
        LearnNowButton.alpha = 0
        milk.alpha = 0
        cerealBox.alpha = 0
     
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!))
        }
        catch{
            print(error)
        }
        audioPlayer.volume = 0
        audioPlayer.play()
        audioPlayer.setVolume(0.07, fadeDuration: 2)
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.HowToLabel.center.y = self.HowToLabel.center.y + 400
        } , completion: nil)
        
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.LearnNowButton.center.y = self.LearnNowButton.center.y + 200
            self.LearnNowButton.alpha = 1
            
        } , completion: nil)
        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            self.milk.center.y = self.milk.center.y + 300
            self.milk.alpha = 1
            
        } , completion: nil)
        
        UIView.animate(withDuration: 3, delay: 0.5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: [], animations: {
            self.cerealBox.center.y = self.cerealBox.center.y + 360
            self.cerealBox.center.x = self.cerealBox.center.x + 185

            self.cerealBox.alpha = 1
            
            
        } , completion: nil)
        
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

