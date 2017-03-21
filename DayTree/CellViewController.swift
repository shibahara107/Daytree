//
//  CellViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/03/21.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class CellViewController: UIViewController {
    
    @IBOutlet var cellDateLabel: UILabel!
    var selectedDate: String = ""
    
    @IBOutlet var cellContentTextField: UITextView!
    var selectedContent: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        cellDateLabel.text = selectedDate
        cellContentTextField.text = selectedContent

        
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
