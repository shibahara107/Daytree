//
//  SettingsViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/08/25.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import Accounts

class SettingsViewController: UIViewController {
    
    @IBOutlet var IntroButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func IntroView() {
        self.performSegue(withIdentifier: "toIntroView2", sender: nil)
    }
    
    @IBAction func share() {
        
        // 共有する項目
        let shareText = "DayTree - Your life and nature, combined."
        let shareWebsite = NSURL(string: "")!
        let shareImage = UIImage(named: "Intro1.png")
        
        let activityItems = [shareText, shareWebsite, shareImage] as [Any]
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        // 使用しないアクティビティタイプ
        let excludedActivityTypes = [
            UIActivityType.saveToCameraRoll,
            UIActivityType.print
        ]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)
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
