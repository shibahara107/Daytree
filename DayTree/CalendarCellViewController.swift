//
//  CalendarCellViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/10/06.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit

class CalendarCellViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    var selectedDate: String = ""
    var selectedContent: String = ""
    var selectedNumber: String = ""
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dateLabel.text = selectedDate
        textView.text = selectedContent
        numberLabel.text = selectedNumber
        
        imageFromCameraRoll.image = loadImageFromPath(path: fileInDocumentsDirectory(filename: selectedDate))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path) @CalendarCellViewController")
        }
        return image
    }
    
    //入る場所を指定してる
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
        
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
