//
//  FirstStep.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit

class SecondStep: UIViewController {

    @IBOutlet weak var Milk: UIImageView!
    @IBOutlet weak var Bowl: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var Counter: UILabel!
    
    var location = CGPoint(x: 0, y: 0)
    var counter:Int = 0
    var timer = Timer()
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    //Still to fix
    @IBAction func ResetAction(_ sender: Any) {
        
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
        Counter.text = "\(counter)"
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch : UITouch! =  touches.first! as UITouch
        if touch.view == Milk
        {
            if(timer.isValid){timer.invalidate()}
        }
    }
    
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
                    timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                }
            }
            else
            {
                if(timer.isValid){timer.invalidate()}
            }
            if(counter >= 10)
            {
                Bowl.image = UIImage(named:"overfille_noScale")
                ResetButton.isHidden = false;
                NextButton.isHidden = true;
            }
            else if(counter >= 6)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp3")
                NextButton.isHidden = false
            }
            else if(counter >= 4)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp2")
            }
            else if(counter >= 2)
            {
                Bowl.image = UIImage(named:"bowl_cerealMilkp1")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Milk.isUserInteractionEnabled = true
        
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
