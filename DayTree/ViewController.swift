//
//  ViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/02/10.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    var searchResults:[Any] = []
    var currentTreeTag: Int = 0
    
    @IBOutlet var dateTableView: UITableView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    
    @IBOutlet var IntroButton: UIButton!
    
    let userDefaults = UserDefaults.standard
    let userdefaults = UserDefaults.standard
    
    // section毎の画像配列
    var imgArray: [String] = ["green.png"]
    
    var entryArray = [[String]]()
    
    var dateString: String = ""
    
    var selectedDateText: String = ""
    var selectedContentText: String = ""
    var selectedNumberText: String = ""
    
    var searchBar: UISearchBar!
    var filtered: [[String]] = []
    var searchActive : Bool = false
    
    var number: Int = 0
    
    let addedDate = Date()
    var addedDate2 = Date()
    var addedDateString = String()
    var addedDateString2 = String()
    var selectedAddedDateString = String()
    
    var identifier = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        imageFromCameraRoll.layer.masksToBounds = true
        //        imageFromCameraRoll.layer.cornerRadius = imageFromCameraRoll.frame.height/2
        
        setupSearchBar()
        searchBar.delegate = self
        
        dateTableView.delegate = self
        dateTableView.dataSource = self
        
        self.dateTableView.setContentOffset(CGPoint(x:0 , y: 45), animated: true)
        
        userDefaults.array(forKey: "Key")
        entryArray = userDefaults.array(forKey: "Key") as? [[String]] ?? []
        
        let color2 = UIColor(rgb: 0x00A651)
        navigationController?.navigationBar.barTintColor = color2
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        entryArray = userDefaults.array(forKey: "Key") as? [[String]] ?? []
        self.dateTableView.reloadData()
        
    }
    
    
    //addButtonが押された際呼び出される
    @IBAction func addCell(sender: AnyObject) {
        print("追加")
        
        let date = Date()
        
        
        //textの表示はalertのみ。ActionSheetだとtextfiledを表示させようとすると
        //落ちます。
        let alert:UIAlertController = UIAlertController(title:"Entry",
                                                        message: "What happened today?",
                                                        preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
                                                        print("Cancel")
        })
        let defaultAction:UIAlertAction = UIAlertAction(title: "Save",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            print("Save")
                                                            
                                                            
                                                            let dataText = alert.textFields![0].text! as String
                                                            let contentText = alert.textFields![1].text! as String
                                                            
                                                            let dateFormatter = DateFormatter()
                                                            dateFormatter.dateFormat = "yyyyMMddHHmmss"
                                                            print(self.addedDate)
                                                            self.addedDate2 = Date()
                                                            self.addedDateString = dateFormatter.string(from: (self.addedDate2))
                                                            
                                                            self.entryArray.append([dataText,contentText,self.addedDateString,])
                                                            print(dataText, contentText, self.addedDateString)
                                                            self.userDefaults.set(self.entryArray, forKey: "Key")
                                                            
                                                            self.dateTableView.reloadData()
                                                            
                                                            self.userdefaults.integer(forKey: "Tree")
                                                            self.currentTreeTag = (self.userdefaults.integer(forKey: "Tree"))
                                                            self.currentTreeTag = self.currentTreeTag + 1
                                                            print(self.currentTreeTag)
                                                            self.userdefaults.set(self.currentTreeTag, forKey: "Tree")
                                                            
        })
        
        dateTableView.reloadData()
        
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            //現在時刻を文字列で取得
            self.dateString = formatter.string(from: date)
            
            text.text = self.dateString
            
            //対象UITextFieldが引数として取得できる
            text.placeholder = "Date"
        })
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "What happened?"
            
        })
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
        
        // TableViewを再読み込み.
        dateTableView.reloadData()
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
            print("missing image at: \(path) @ViewController")
        }
        return image
    }
    
    //入る場所を指定してる
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
        
    }
    
    @IBAction func IntroView() {
        self.performSegue(withIdentifier: "toIntroView", sender: nil)
    }
    
    //Segue準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toCellViewController") {
            let subVC: CellViewController = (segue.destination as? CellViewController)!
            //CellViewControllerのselectedDateTextに選択された値を設定する
            subVC.selectedDate = selectedDateText
            subVC.selectedContent = selectedContentText
            subVC.selectedNumber = selectedNumberText
            subVC.number0 = number
            subVC.addedDateString2 = identifier
        }
    }
    
    
    @IBAction func returnTableView(segue: UIStoryboardSegue) {}
}

extension ViewController : UITableViewDelegate {
    // MARK: - This is UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return entryArray.count
        
    }
    
}

extension ViewController : UISearchBarDelegate {
    // MARK: - This is UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
        searchBar.text = ""
        self.dateTableView.reloadData()
    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("nagata")
        searchActive = true
        
        filtered.removeAll()
        
        for i in entryArray {
            
            if i[1].contains(searchBar.text!) {
                
                filtered.append(i)
                
            } else {
                
            }
            
        }
        
        for i in entryArray {
            
            if i[0].contains(searchBar.text!) {
                
                filtered.append(i)
                
            } else {
                
            }
            
        }
        
        
        self.dateTableView.reloadData()
    }
    
    func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.barTintColor = UIColor.white
            searchBar.placeholder = "Search"
            searchBar.showsCancelButton = true
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
            //            searchBar.becomeFirstResponder()
        }
    }
    
}

extension ViewController : UITableViewDataSource {
    // MARK: - This is UITableViewDataSource
    
    //Cellを挿入または削除しようとした際に呼び出される
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除のとき
        if editingStyle == .delete {
            entryArray.remove(at: entryArray.count - indexPath.row-1)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let dispatchTime: DispatchTime = DispatchTime.now() + 0.7
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                self.dateTableView.reloadData()
                print("delay")
            })
            
            print("Delete")
            self.userDefaults.set(self.entryArray, forKey: "Key")
        }
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var temporaryArray = [[String]]()
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")! as UITableViewCell;
        if(searchActive){
            temporaryArray = filtered
        } else {
            temporaryArray = entryArray
        }
        
        // セルを取得する
        // セルに表示する値を設定するÏ
        // cell.textLabel!.text = fruits[indexPath.row]
        
        
        
        // Tag番号 1 で UIImageView インスタンスの生成
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
    
    //Cellが選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //[indexPath.row]から日付を探し値を設定
        selectedDateText = "\(entryArray[entryArray.count - indexPath.row-1][0])"
        
        selectedContentText = "\(entryArray[entryArray.count - indexPath.row-1][1])"
        
        selectedNumberText = "No.\(entryArray.count - indexPath.row)"
        
        number = entryArray.count - indexPath.row-1
        
        identifier = "\(entryArray[entryArray.count - indexPath.row-1][2])"
        
        //CellViewControllerへ遷移するためにSegueを呼び出す
        performSegue(withIdentifier: "toCellViewController",sender: nil)
        
        print("セル番号：\(entryArray[entryArray.count - indexPath.row-1][0]) セルの内容：\(entryArray[entryArray.count - indexPath.row-1][1])  セル作成日：\(entryArray[entryArray.count - indexPath.row-1][2])")
        
    }
    
    
}
