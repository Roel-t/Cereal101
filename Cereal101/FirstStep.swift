//
//  FirstStep.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit

class FirstStep: UIViewController {

    @IBOutlet weak var Milk: UIImageView!
    @IBOutlet weak var Bowl: UIImageView!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    var location = CGPoint(x: 0, y: 0)
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! =  touches.first! as UITouch
        if touch.view == Milk
        {
            location = touch.location(in: self.view)
            Milk.center = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch : UITouch! =  touches.first! as UITouch
        if touch.view == Milk
        {
            location = touch.location(in: self.view)
            Milk.center = location
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Milk.isUserInteractionEnabled = true
        
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
