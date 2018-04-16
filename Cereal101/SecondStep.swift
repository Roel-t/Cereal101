//
//  FirstStep.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit
import AVFoundation

class SecondStep: UIViewController {

    @IBOutlet weak var Milk: UIImageView!
    @IBOutlet weak var Bowl: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var audioPlayer = AVAudioPlayer()
    var location = CGPoint(x: 0, y: 0)
    var OGLocation = CGPoint(x: 0, y: 0)
    var counter:Double = 0
    var timer = Timer()
    var tilted = false

    //Check if milk has moved
    var PrevLocation = CGPoint(x: 0, y: 0)
    var CurLocation = CGPoint(x: 0, y: 0)
    
    
    @IBAction func BackButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1105)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ResetAction(_ sender: Any) {
        counter = 0
        Milk.center = OGLocation
        Bowl.image = UIImage(named:"bowl_cerealp4")
        ResetButton.isHidden = true
    }
    @IBAction func NextButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1104)

    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
    }
    
    func boxAndBowlIntersectCheck(tilt: Bool, time: Timer)
    {
        if(time.isValid){time.invalidate()}
        if(tilt)
        {
            tilted = false
            Milk.image = UIImage(named:"milkNonTilted")
        }
        if(audioPlayer.isPlaying)
        {
            audioPlayer.stop()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        boxAndBowlIntersectCheck(tilt: tilted, time: timer)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        boxAndBowlIntersectCheck(tilt: tilted, time: timer)
    }
    
    //TODO: Track the cereal box cgppoint prev and if it stays the same then stop the counter
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        
        if touch.view == Milk
        {
            location = touch.location(in: self.view)
            Milk.center = location
            if (Milk.frame.intersects(Bowl.frame))
            {
                if (!timer.isValid)
                {
                    // start the timer
                    timer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                    audioPlayer.numberOfLoops = 10
                    audioPlayer.play()
                }
                if(!tilted)
                {
                    Milk.image = UIImage(named:"milkPouring")
                    tilted = true;
                }
                
                //Checks if User is holding Cereal over Bowl
                if case -1 ... 1 = Float(PrevLocation.x) - Float(CurLocation.x)
                {
                    if case -1 ... 1 = Float(PrevLocation.y) - Float(CurLocation.y)
                    {
                        boxAndBowlIntersectCheck(tilt: tilted, time: timer)
                    }
                }
            }
            else
            {
                boxAndBowlIntersectCheck(tilt: tilted, time: timer)
            }
            
            if (counter >= 10)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp4")
                ResetButton.isHidden = false
                NextButton.isHidden = true
            }
            else if(counter >= 7)
            {
                if(counter == 7){
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    counter = 7.1
                }
                Bowl.image = UIImage(named:"bowl_cerealMilkp3")
                NextButton.isHidden = false
            }
            else if(counter >= 4)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp2")
                
            }
          
            else if(counter >= 1)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp1")
            }
            
            PrevLocation = CurLocation
            CurLocation = Milk.center
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "pour", ofType: "mp3")!))
        }
        catch{
            print(error)
        }

        OGLocation = Milk.center
        PrevLocation = Milk.center
        Milk.isUserInteractionEnabled = true
        BackButton.layer.cornerRadius = 4
        NextButton.layer.cornerRadius = 4
        ResetButton.layer.cornerRadius = 4
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
