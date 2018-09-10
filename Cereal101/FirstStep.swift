//
//  SecondStep.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation


class FirstStep: UIViewController {

    @IBOutlet weak var Cereal: UIImageView!
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
    
    //Check if cereal has moved
    var PrevLocation = CGPoint(x: 0, y: 0)
    var CurLocation = CGPoint(x: 0, y: 0)
    
    @IBAction func BackButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1105)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func ResetButton(_ sender: Any) {
        counter = 0
        Cereal.center = OGLocation
        Bowl.image = UIImage(named:"bowl_empty")
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
            Cereal.image = UIImage(named:"cerealBoxNonTilt")
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
       
        if touch.view == Cereal
        {
            location = touch.location(in: self.view)
            Cereal.center = location
            if (Cereal.frame.intersects(Bowl.frame))
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
                    Cereal.image = UIImage(named:"cerealBoxTilted")
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
                Bowl.image = UIImage(named:"bowl_cerealOverFill")
                ResetButton.isHidden = false
                NextButton.isHidden = true
            }
            else if(counter >= 7)
            {
                if(counter == 7){
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    counter = 7.1
                }
                Bowl.image = UIImage(named:"bowl_cerealp4")
                NextButton.isHidden = false
            }
            else if(counter >= 5)
            {
                Bowl.image = UIImage(named:"bowl_cerealp3")
                
            }
            else if(counter >= 3)
            {
                Bowl.image = UIImage(named:"bowl_cerealp2")
            }
            else if(counter >= 1)
            {
                Bowl.image = UIImage(named:"bowl_cerealp1")
            }
        
            PrevLocation = CurLocation
            CurLocation = Cereal.center
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "sample", ofType: "mp3")!))
        }
        catch{
            print(error)
        }
        
        OGLocation = Cereal.center
        PrevLocation = Cereal.center
        Cereal.isUserInteractionEnabled = true
        NextButton.layer.cornerRadius = 4
        ResetButton.layer.cornerRadius = 4
        BackButton.layer.cornerRadius = 4
       
   
        
        // Do any additional setup after loading the view.
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
