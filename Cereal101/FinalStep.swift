//
//  FinalStep.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit
import SAConfettiView
import AVFoundation


class FinalStep: UIViewController {

    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var Spoon: UIImageView!
    @IBOutlet weak var Bowl: UIImageView!
    @IBOutlet weak var MainMenuH: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var location = CGPoint(x: 0, y: 0)
    var confettiView:SAConfettiView?
    var confettiPlayer = AVAudioPlayer()

    
    @IBAction func BackButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1105)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func MainMenu(_ sender: Any) {
        AudioServicesPlaySystemSound (1104)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        if touch.view == Spoon
        {
            location = touch.location(in: self.view)
            Spoon.center = location
            if (Spoon.frame.intersects(Bowl.frame))
            {
                
                Bowl.image = UIImage(named:"bowl_cerealMilkSpoon")
                Bowl.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width/4, y: 0)
                Spoon.isHidden = true
                MainMenuH.isHidden = false
                confettiView?.startConfetti()
                confettiPlayer.play()
        

            }
           
           
        }
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            confettiPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "winner", ofType: "mp3")!))
            confettiPlayer.prepareToPlay()
        }
        catch{
            print(error)
        }

    
        
        confettiView = SAConfettiView(frame: view.bounds)
        confettiView?.intensity = 0.35
        
        Background.addSubview(confettiView!)
        MainMenuH.layer.cornerRadius = 4;
        BackButton.layer.cornerRadius = 4;
        
    }

}
