//
//  PlanetViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/09/17.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class PlanetViewController: UIViewController {
    
    @IBOutlet var betterPlanetImageView: UIImageView!
    @IBOutlet var tapLabel: UILabel!
    
    let reStartButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        UIView.animate(withDuration: 5.0) { () -> Void in
            self.betterPlanetImageView.alpha = 1.0
        }
        
        let dispatchTime: DispatchTime = DispatchTime.now() + 5.0
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            print("delay")
            UIView.animate(withDuration: 2.0) { () -> Void in
                self.reStartButton.frame = CGRect(x: 0, y: 0, width: 900, height: 1600)
                self.reStartButton.backgroundColor = UIColor.clear
                self.reStartButton.addTarget(self, action: #selector(PlanetViewController.backToView(sender:)), for: .touchUpInside)
                self.view.addSubview(self.reStartButton)
                print("reStartButton SUCCESS")
                
            }
            
            UIView.animate(withDuration: 3.0) { () -> Void in
                self.tapLabel.alpha = 1.0
                
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToView (sender: Any) {
        print("reStart")
        performSegue(withIdentifier: "reStart", sender: nil)
        
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
