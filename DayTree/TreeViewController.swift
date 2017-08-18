//
//  treeViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/08/05.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class TreeViewController: UIViewController {

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var treeButton: UIButton!
    @IBOutlet var resetTag: UIButton!
    
    var currentTreeTag: Int = 0
    
    let userdefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(currentTreeTag)


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showTree(sender: AnyObject) {
        if self.currentTreeTag < 31 {
        UIView.animate(withDuration: 2.0) { () -> Void in
            self.userdefaults.integer(forKey: "Tree")
            self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
            self.currentTreeTag = self.currentTreeTag + 1
            print(self.currentTreeTag)
            let treeImageView = self.view.viewWithTag(self.currentTreeTag) as! UIImageView
            treeImageView.alpha = 1.0
            self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
            }
        }else if self.currentTreeTag < 38 {
        UIView.animate(withDuration: 2.0) { () -> Void in
            self.userdefaults.integer(forKey: "Tree")
            self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
            self.currentTreeTag = self.currentTreeTag + 1
            print(self.currentTreeTag)
            let greenImageView = self.view.viewWithTag(self.currentTreeTag) as! UIImageView
            greenImageView.alpha = 1.0
            self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
            }
            }else {
                self.userdefaults.integer(forKey: "Tree")
                self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
                self.currentTreeTag = 0
                self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
                print(self.currentTreeTag)
            }
    }
    
    func resetCurrentTreeTag() {
        self.userdefaults.integer(forKey: "Tree")
        self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
        self.currentTreeTag = 0
        self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
        print(self.currentTreeTag)
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
