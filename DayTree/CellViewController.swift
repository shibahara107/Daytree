//
//  CellViewController.swift
//  DayTree
//
//  Created by Yoshi on 2017/03/21.
//  Copyright © 2017 Yoshi. All rights reserved.
//

import UIKit
import Photos

extension String {
    
    private var ns: NSString {
        return (self as NSString)
    }
    
    public func substring(from index: Int) -> String {
        return ns.substring(from: index)
    }
    
    public func substring(to index: Int) -> String {
        return ns.substring(to: index)
    }
    
    public func substring(with range: NSRange) -> String {
        return ns.substring(with: range)
    }
    
    public var lastPathComponent: String {
        return ns.lastPathComponent
    }
    
    public var pathExtension: String {
        return ns.pathExtension
    }
    
    public var deletingLastPathComponent: String {
        return ns.deletingLastPathComponent
    }
    
    public var deletingPathExtension: String {
        return ns.deletingPathExtension
    }
    
    public var pathComponents: [String] {
        return ns.pathComponents
    }
    
    public func appendingPathComponent(_ str: String) -> String {
        return ns.appendingPathComponent(str)
    }
    
    public func appendingPathExtension(_ str: String) -> String? {
        return ns.appendingPathExtension(str)
    }
}


class CellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cellDateLabel: UILabel!
    var selectedDate: String = ""
    
    @IBOutlet var cellContentTextField: UITextView!
    var selectedContent: String = ""
    
    @IBOutlet var cellNumberLabel: UILabel!
    var selectedNumber: String = ""
    
    @IBOutlet weak var imageFromCameraRoll: UIImageView!
    @IBOutlet var cameraRoll: UIButton!
    
    /// 画像ファイルの保存先パスを生成します（ドキュメントフォルダ直下固定）。
    var imagePath: String {
        let doc = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = doc.appendingPathComponent("green.png") // OK!
        print(path) // "path/to/foo/test.txt"
        
        return path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellDateLabel.text = selectedDate
        cellContentTextField.text = selectedContent
        cellNumberLabel.text = selectedNumber
        
        imageFromCameraRoll.contentMode = .scaleAspectFit
        self.imageFromCameraRoll.layer.borderColor = UIColor.gray.cgColor
        self.imageFromCameraRoll.layer.borderWidth = 1


        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        func pressCameraRoll(sender: AnyObject) {
            
        }
        
        
        //ライブラリから写真を選択する
        func pickImageFromLibrary() {
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                
                //写真ライブラリ(カメラロール)表示用のViewControllerを宣言しているという理解
                let controller = UIImagePickerController()
                
                //おまじないという認識で今は良いと思う
                controller.delegate = self
                
                //新しく宣言したViewControllerでカメラとカメラロールのどちらを表示するかを指定
                //以下はカメラロールの例
                //.Cameraを指定した場合はカメラを呼び出し(シミュレーター不可)
                controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
                
                //新たに追加したカメラロール表示ViewControllerをpresentViewControllerにする
                self.present(controller, animated: true, completion: nil)
            }
        }
        
        
        
        }
    
    //カメラロールボタンを押した時
    @IBAction func cameraRoll(sender: AnyObject) {
        self.pickImageFromLibrary()  //ライブラリから写真を選択する
        
    }
         //写真を選択した時に呼ばれる
         //:param: picker:おまじないという認識で今は良いと思う
         //:param: didFinishPickingMediaWithInfo:おまじないという認識で今は良いと思う
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
            
            //このif条件はおまじないという認識で今は良いと思う
        if didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] != nil {
                
                //didFinishPickingMediaWithInfo通して渡された情報(選択された画像情報が入っている？)をUIImageにCastする
                //そしてそれを宣言済みのimageViewへ放り込む
            imageFromCameraRoll.image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage
        }
            
            //写真選択後にカメラロール表示ViewControllerを引っ込める動作
        picker.dismiss(animated: true, completion: nil)
    }
    

// ライブラリから写真を選択する
    func pickImageFromLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    // 写真を選択した時に呼ばれる
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageFromCameraRoll.contentMode = .scaleToFill
            imageFromCameraRoll.image = pickedImage
//
//            let image = pickedImage
//            let data = UIImageJPEGRepresentation(image, 0.9)
//            data.writeToFile(imagePath, atomically: true)
//            print("save: \(imagePath)")
//        }
        }
        
        picker.dismiss(animated: true, completion: nil)
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


