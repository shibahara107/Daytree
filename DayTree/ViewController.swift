//
//  ViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/02/10.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import Photos



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var searchResults:[Any] = []
    
    @IBOutlet var dateTableView: UITableView!
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!

    
    // section毎の画像配列
    var imgArray: [String] = ["green.png"]
    
    var entryArray = [[String]]()
    
    var dateArray: [String] = ["↑First Day↑"]
    
    var dateString: String = ""
    
    var selectedDateText: String = ""
    var selectedContentText: String = ""
    var selectedNumberText: String = ""
    
    var searchBar: UISearchBar!
    var filtered: [[String]] = []
    var searchActive : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        setupSearchBar()
        searchBar.delegate = self
        
        dateTableView.delegate = self
        dateTableView.dataSource = self
        
        self.dateTableView.setContentOffset(CGPoint(x:0 , y: 45), animated: true)
        
        entryArray.append(["Date","San Francisco"])
        entryArray.append(["Date2","New York"])

        
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
                                                            
                                                            self.entryArray.append([dataText,contentText])
                                                            
                                                            //                                                        let textFields:Array<UITextField>? =  alert.textFields?[0] as Array<UITextField>?
                                                            //                                                        if textFields != nil {
                                                            //                                                            for textField:UITextField in textField.Array {
                                                            //
                                                            //                                                                self.entryArray.append(textField.text!)
                                                            //                                                                self.imgArray.append("img0.jpg")
                                                            //
                                                            // TableViewを再読み込み.
                                                            self.dateTableView.reloadData()
                                                            //
                                                            //                                                                //各textにアクセス
                                                            //                                                                print(textField.text)
                                                            //                                                            }
                                                            //                                                        }
                                                            
                                                            
                                                            imageFromCameraRoll.image = loadImageFromPath(path: fileInDocumentsDirectory(filename: entryArray[0]))

        })
        
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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        searchBar.text = ""
        self.dateTableView.reloadData()
    }
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchActive = false;
    //    }
    
    // 検索ボタンが押された時に呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("nagata")
        searchActive = true
        
        for i in entryArray {
            
            if i[1].contains(searchBar.text!) {
                
                filtered.append(i)
                
            } else {
                
            }
            
        }
        self.dateTableView.reloadData()
    }
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //
    //        searchActive = true
    //
    //        filtered = []
    //
    //        for i in entryArray {
    //
    //            if i[1].contains(searchText) {
    //
    //                filtered.append(i)
    //
    //            } else {
    //
    //            }
    //
    //        }
    //
    //
    //        self.dateTableView.reloadData()
    
    
    
    
    
    
    
    
    
    //Cellを挿入または削除しようとした際に呼び出される
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // 削除のとき
        if editingStyle == .delete {
            entryArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let dispatchTime: DispatchTime = DispatchTime.now() + 0.7
            DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
                self.dateTableView.reloadData()
                print("delay")
            })
            
            print("Delete")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupSearchBar() {
        if let navigationBarFrame = navigationController?.navigationBar.bounds {
            let searchBar: UISearchBar = UISearchBar(frame: navigationBarFrame)
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            searchBar.showsCancelButton = true
            searchBar.autocapitalizationType = UITextAutocapitalizationType.none
            searchBar.keyboardType = UIKeyboardType.default
            navigationItem.titleView = searchBar
            navigationItem.titleView?.frame = searchBar.frame
            self.searchBar = searchBar
            searchBar.becomeFirstResponder()
        }
    }
    
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
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")! as UITableViewCell;
        if(searchActive){
            // cell.textLabel?.text = filtered[indexPath.row][1];
        } else {
            // cell.textLabel?.text = entryArray[indexPath.row][1];
        }
        
        // セルを取得する
        // セルに表示する値を設定する
        // cell.textLabel!.text = fruits[indexPath.row]
        
        
        
        // img = UIImage(named:"\(imgArray[indexPath.row])")
        // Tag番号 1 で UIImageView インスタンスの生成
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = imageFromCameraRoll.image
        
        // Tag番号 ２ で UILabel インスタンスの生成
        let label1 = cell.viewWithTag(2) as! UILabel
        label1.text = "\(entryArray[entryArray.count - indexPath.row-1][0])"
        
        // Tag番号 ３ で UILabel インスタンスの生成
        let entry = cell.viewWithTag(3) as! UILabel
        entry.text = "\(entryArray[entryArray.count - indexPath.row-1][1])"
        
        let label2 = cell.viewWithTag(4) as! UILabel
        label2.text = "No.\(entryArray.count - indexPath.row)"
        
        
        return cell
    }
    
    //Cellが選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        //[indexPath.row]から日付を探し値を設定
        selectedDateText = "\(entryArray[entryArray.count - indexPath.row-1][0])"
        
        selectedContentText = "\(entryArray[entryArray.count - indexPath.row-1][1])"
        
        selectedNumberText = "No.\(entryArray.count - indexPath.row)"
        
        //CellViewControllerへ遷移するためにSegueを呼び出す
        performSegue(withIdentifier: "toCellViewController",sender: nil)
        
        
        print("セル番号：\(entryArray[entryArray.count - indexPath.row-1][0]) セルの内容：\(entryArray[entryArray.count - indexPath.row-1][1]) ")
        
        
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path)")
        }
        return image
    }
    
    //入る場所を指定してる
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
        
    }
    
    //Segue準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toCellViewController") {
            let subVC: CellViewController = (segue.destination as? CellViewController)!
            //CellViewControllerのselectedDateTextに選択された値を設定する
            subVC.selectedDate = selectedDateText
            subVC.selectedContent = selectedContentText
            subVC.selectedNumber = selectedNumberText
        }
    }
    
    
    @IBAction func returnTableView(segue: UIStoryboardSegue) {}
}

