//
//  treeViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/08/05.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import SpriteKit

class TreeViewController: UIViewController {
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var treeButton: UIButton!
    @IBOutlet var resetTag: UIButton!
    @IBOutlet var rainButton: UIButton!
    @IBOutlet var stopRainButton: UIButton!
    @IBOutlet var rainSkyImageView: UIImageView!
    @IBOutlet var rainFogImageView: UIImageView!
    
    var currentTreeTag: Int = 0
    var appearTreeTag: Int = 0
    
    var skView: SKView?
    var scene = SKScene()
    
    let userdefaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.appearTreeTag = 0
        
        self.userdefaults.integer(forKey: "Tree")
        self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
        print(currentTreeTag)
        if self.currentTreeTag > 0 {
            for _ in 0...Int(currentTreeTag) - 1 {
                if self.currentTreeTag < 38 {
                    UIView.animate(withDuration: 2.0) { () -> Void in
                        self.appearTreeTag = self.appearTreeTag + 1
                        print("appearTreeTag:", self.appearTreeTag)
                        let treeImageView = self.view.viewWithTag(self.appearTreeTag) as! UIImageView
                        treeImageView.alpha = 1.0
                    }
                }else {
                    break
                }
            }
        }else {
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSKView()
        
        skView?.isUserInteractionEnabled = false
        
        self.userdefaults.integer(forKey: "Tree")
        self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
        print("viewDidLoad:", currentTreeTag)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
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
    
    @IBAction func resetCurrentTreeTag() {
        self.userdefaults.integer(forKey: "Tree")
        self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
        self.currentTreeTag = 0
        self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
        print(self.currentTreeTag)
        self.appearTreeTag = 0
        print("appearTreeTag:", appearTreeTag)
    }
    
    @IBAction func makeRain() {
        UIView.animate(withDuration: 2.0) { () -> Void in
            _ = UIImage(named: "rainSky.png")
            self.rainSkyImageView.alpha = 1.0
            _ = UIImage(named: "rainFog.png")
            self.rainFogImageView.alpha = 1.0
        }
    }
    
    @IBAction func stopRain() {
        UIView.animate(withDuration: 2.0) { () -> Void in
            _ = UIImage(named: "rainSky.png")
            self.rainSkyImageView.alpha = 0.0
            _ = UIImage(named: "rainFog.png")
            self.rainFogImageView.alpha = 0.0
        }
    }
    
    func createSKView() {
        self.skView = SKView(frame: self.view.frame)
        self.skView!.allowsTransparency = true
    }
    
    @IBAction func setupParticle() {
        scene = SKScene(size: self.view.frame.size)
        scene.backgroundColor = UIColor.clear
        
        let path = Bundle.main.path(forResource: "rain", ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        particle.name = "Rain"
        particle.position = CGPoint(x: self.view.frame.width * (3/4), y: self.view.frame.height)
        //particle.frame.size.width = self.view.frame.width
        scene.addChild(particle)
        
        let particle2 = NSKeyedUnarchiver.unarchiveObject(withFile: path!) as! SKEmitterNode
        particle2.name = "Rain"
        particle2.position = CGPoint(x: self.view.frame.width * (1/4), y: self.view.frame.height)
        //particle.frame.size.width = self.view.frame.width
        scene.addChild(particle2)
        
        self.skView!.presentScene(scene)
        self.view.addSubview(self.skView!)
    }
    
    @IBAction func closeParticle() {
        UIView.animate(withDuration: 2.0) { () -> Void in

        self.scene.removeAllChildren()
        
        }
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
