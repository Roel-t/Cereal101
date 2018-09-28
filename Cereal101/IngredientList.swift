//
//  IngredientList.swift
//  Cereal101
//
//  Created by Roel Tijerina on 4/7/18.
//  Copyright © 2018 Roel Tijerina. All rights reserved.
//

import UIKit
import AVFoundation

class IngredientList: UIViewController {

    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    @IBAction func BackButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1105)

        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func NextButton(_ sender: Any) {
        AudioServicesPlaySystemSound (1104)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        BackButton.layer.cornerRadius = 4
        NextButton.layer.cornerRadius = 4

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
