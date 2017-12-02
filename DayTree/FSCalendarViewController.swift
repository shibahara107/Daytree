//
//  FSCalendarViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/10/04.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import FSCalendar

class FSCalendarScopeExampleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    let userDefaults = UserDefaults.standard
    var entryArray = [[String]]()
    var addedDateStringCompare: String = ""
    
    var filtered: [[String]] = []
    @IBOutlet var dateTableView: UITableView!
    var selectedDates: String!
    
    var selectedDateText: String = ""
    var selectedContentText: String = ""
    var selectedNumberText: String = ""
    var number: Int = 0
    
    var temporaryArray = [[String]]()
    
    var madeDates: String = ""
    var number0: Int = 0
//    var date2: Date
    
    var selectedDateForPath: String = ""
    var selectedDateForPathText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }
        
        self.calendar.select(Date())
        
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        let color2 = UIColor(rgb: 0x00A651)
        navigationController?.navigationBar.barTintColor = color2
        navigationController?.navigationBar.tintColor = UIColor.white
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
    }
    
    deinit {
        print("\(#function)")
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        filtered.removeAll()
        self.dateTableView.reloadData()
        print("did select date \(self.dateFormatter.string(from: date))")
//        selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        selectedDates = self.dateFormatter.string(from: date)
        print("selected dates is \(selectedDates)")
//        date2 = entryArray[number0][2]
//        madeDates = self.dateFormatter.string(from: date2)
        entryArray = userDefaults.array(forKey: "Key") as? [[String]] ?? []
        number0 = 0
        madeDates = String(entryArray[number0][3])
        
        for _ in 0...Int(entryArray.count-1) {
            if selectedDates.contains(madeDates) {
            print("Found Same Date")
                
                print("Filter Start")
                
                filtered.removeAll()
                
                for i in entryArray {
                    
                    if i[3].contains(selectedDates) {
                        
                        filtered.append(i)
                        
                    } else {
                        
                    }
                    
                }
                
                print("Filter End")
                self.dateTableView.reloadData()
                
            break
        }else {
            number0 = number0+1
            print("No Date Found")
        }
        }
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var temporaryArray = [[String]]()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell;
            temporaryArray = filtered

        let imageView = cell.viewWithTag(1) as! UIImageView
        if let image = loadImageFromPath(path: fileInDocumentsDirectory(filename: temporaryArray[temporaryArray.count - indexPath.row-1][2])) {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "DefaultEntry2.png")
        }
        cell.viewWithTag(1)!.layer.masksToBounds = true
        cell.viewWithTag(1)!.layer.cornerRadius = cell.viewWithTag(1)!.frame.height/2
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = cell.viewWithTag(2) as! UILabel
        label1.text = "\(temporaryArray[temporaryArray.count - indexPath.row-1][0])"
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let entry = cell.viewWithTag(3) as! UILabel
        entry.text = "\(temporaryArray[temporaryArray.count - indexPath.row-1][1])"
        
        let label2 = cell.viewWithTag(4) as! UILabel
        label2.text = "No.\(temporaryArray.count - indexPath.row)"
        
        return cell

    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path) @FSCalendarViewController")
        }
        return image
    }
    
    //入る場所を指定してる
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
        
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    
    // MARK:- UITableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        temporaryArray = filtered

        //[indexPath.row]から日付を探し値を設定
        selectedDateText = "\(temporaryArray[temporaryArray.count - indexPath.row-1][0])"
        
        selectedContentText = "\(temporaryArray[temporaryArray.count - indexPath.row-1][1])"
        
        selectedNumberText = "No.\(temporaryArray.count - indexPath.row)"
        
        selectedDateForPath = "\(temporaryArray[temporaryArray.count - indexPath.row-1][2])"
        
        //CellViewControllerへ遷移するためにSegueを呼び出す
        performSegue(withIdentifier: "toCalendarCellViewController",sender: nil)
        
        print("セル番号：\(entryArray[entryArray.count - indexPath.row-1][0]) セルの内容：\(entryArray[entryArray.count - indexPath.row-1][1])  セル作成日：\(entryArray[entryArray.count - indexPath.row-1][2])")
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK:- Target actions
    
    @IBAction func toggleClicked(sender: AnyObject) {
        if self.calendar.scope == .month {
            self.calendar.setScope(.week, animated: true)
        } else {
            self.calendar.setScope(.month, animated: true)
        }
    }
    
    //Segue準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toCalendarCellViewController") {
            let subVC: CalendarCellViewController = (segue.destination as? CalendarCellViewController)!
            //CellViewControllerのselectedDateTextに選択された値を設定する
            subVC.selectedDate = selectedDateText
            subVC.selectedContent = selectedContentText
            subVC.selectedNumber = selectedNumberText
            subVC.selectedDateForPathText = selectedDateForPath
        }
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


