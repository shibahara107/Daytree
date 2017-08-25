//
//  File.swift
//  DayTree
//
//  Created by Yoshi on 2017/08/25.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import Foundation
import UIKit

class ParentTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let selectesIconNames = ["Image-3", "", "Image-4"]
    let unseletedIconNames = ["Image", "", "Image-2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBigCenterButton()
        self.delegate = self
        
        
        if let count = self.tabBar.items?.count {
            for i in 0...count-1 {
                let imageNameForSelectedState   = selectesIconNames[i]
                let imageNameForUnselectedState = unseletedIconNames[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.clear], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(rgb: 0xFFFFFF)], for: .selected)
        tabBar.barTintColor = UIColor(rgb: 0xFFFFFF)
        
        self.tabBar.items?[0].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        self.tabBar.items?[0].title = nil
        
        self.tabBar.items?[2].imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        self.tabBar.items?[2].title = nil
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is DummyVC {
            performSegue(withIdentifier: "toViewController2", sender: nil)
            return false
        }
        return true
    }
    
    private func setupBigCenterButton(){
        
        let button = UIButton()
        
        button.sizeToFit()
        button.frame.size = CGSize(width: tabBar.bounds.size.height * 1.2, height: tabBar.bounds.size.height * 1.2)
        button.center = CGPoint(x: tabBar.bounds.size.width / 2, y: tabBar.bounds.size.height - (button.bounds.size.height/1.8))
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor(rgb: 0x00A651)
        button.setImage(UIImage(named: "Image-1"), for: .normal)
        
        //button.addTarget(self, action: #selector(self.tapBigCenter(sender:)), for: .touchUpInside)
        
        tabBar.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class DummyVC: UIViewController {}
