//
//  HomeViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/08/25.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import EAIntroView

class IntroViewController: UIViewController, EAIntroDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let page1 = EAIntroPage()
        page1.title = ""
        page1.bgImage = UIImage(named: "Intro1.png")
        page1.desc = ""
        
        let page2 = EAIntroPage()
        page2.title = ""
        page2.bgImage = UIImage(named: "Intro2.png")
        page2.desc = ""
        
        let page3 = EAIntroPage()
        page3.title = ""
        page3.bgImage = UIImage(named: "Intro4.png")
        page3.desc = ""
        
        let page4 = EAIntroPage()
        page4.title = ""
        page4.bgImage = UIImage(named: "Intro3.png")
        page4.desc = ""
        
        let introView = EAIntroView(frame: self.view.frame, andPages: [page1, page2, page3, page4])
        introView?.show(in: self.view, animateDuration: 0.3)
        // Do any additional setup after loading the view.
        
        introView?.delegate = self
    }
    
    func introDidFinish(_ introView: EAIntroView!, wasSkipped: Bool) {
        print("Finished")
        self.dismiss(animated: false, completion: nil)
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
