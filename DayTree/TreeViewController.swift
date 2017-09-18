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
    @IBOutlet var cloudsButton: UIButton!
    @IBOutlet var normWeatherButton: UIButton!
    @IBOutlet var rainSkyImageView: UIImageView!
    @IBOutlet var rainFogImageView: UIImageView!
    @IBOutlet var sunnySkyImageView: UIImageView!
    @IBOutlet var thunderCloudsImageView: UIImageView!
    @IBOutlet var thunderImageView: UIImageView!
    
    @IBOutlet var to37Button: UIButton!
    
    var thunderTag: Int = 0
    var thunderTagArray: [Int] = []
    
    var currentTreeTag: Int = 0
    var appearTreeTag: Int = 0
    
    var skView: SKView?
    var scene = SKScene()
    
    let userdefaults = UserDefaults.standard
    
    var window: UIWindow?
    
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
            
            //windowを生成
            self.window = UIWindow(frame: UIScreen.main.bounds)
            //Storyboardを指定
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //Viewcontrollerを指定
            let planetViewController = storyboard.instantiateViewController(withIdentifier: "planetViewController")
            //rootViewControllerに入れる
            self.window?.rootViewController = planetViewController
            //表示
            self.window?.makeKeyAndVisible()
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
    
    @IBAction func to37() {
        self.userdefaults.integer(forKey: "Tree")
        self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
        self.currentTreeTag = 37
        self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
        print(self.currentTreeTag)
        self.appearTreeTag = 37
        print("appearTreeTag:", appearTreeTag)
    }
    
    @IBAction func makeRain() {
        clearWeather()
        UIView.animate(withDuration: 3.0) { () -> Void in
            _ = UIImage(named: "rainSky.png")
            self.rainSkyImageView.alpha = 1.0
            _ = UIImage(named: "rainFog.png")
            self.rainFogImageView.alpha = 1.0
        }
    }
    
    @IBAction func thunderSky() {
        UIView.animate(withDuration: 3.0) { () -> Void in
            _ = UIImage(named: "rainSky.png")
            self.rainSkyImageView.alpha = 1.0
            _ = UIImage(named: "rainFog.png")
            self.rainFogImageView.alpha = 1.0
            _ = UIImage(named: "ThunderClouds.png")
            self.thunderCloudsImageView.alpha = 1.0
        }
    }
    
    @IBAction func thunderDown() {
        clearWeather()
        thunderTagArray = [101, 102, 103, 104, 105]
        thunderTag = Int(arc4random_uniform(5))
        print("thunderTag:", self.thunderTagArray[thunderTag])
        let thunderImageView = self.view.viewWithTag(self.thunderTagArray[thunderTag]) as! UIImageView
        thunderImageView.alpha = 1.0
        UIView.animate(withDuration: 0.5) { () -> Void in
            thunderImageView.alpha = 0.0
        }
        
    }
    
    @IBAction func makeSunny() {
        clearWeather()
        UIView.animate(withDuration: 5.0) { () -> Void in
            _ = UIImage(named: "SunWeatherSky.png")
            self.sunnySkyImageView.alpha = 1.0
        }
    }
    
    @IBAction func normWeather() {
        clearWeather()
    }
    
    func clearWeather() {
        UIView.animate(withDuration: 2.0) { () -> Void in
            _ = UIImage(named: "rainSky.png")
            self.rainSkyImageView.alpha = 0.0
            _ = UIImage(named: "rainFog.png")
            self.rainFogImageView.alpha = 0.0
            _ = UIImage(named: "SunWeatherSky.png")
            self.sunnySkyImageView.alpha = 0.0
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
