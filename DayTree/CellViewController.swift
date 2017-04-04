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
extension Data {
    @discardableResult
    func write(toFile: String, atomically: Bool) -> Bool {
        return (try? self.write(to: URL(fileURLWithPath: toFile), options: atomically ? .atomic : [])) != nil
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
    
    var imageName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellDateLabel.text = selectedDate
        cellContentTextField.text = selectedContent
        cellNumberLabel.text = selectedNumber
        
        imageFromCameraRoll.contentMode = .scaleAspectFit
        //        self.imageFromCameraRoll.layer.borderColor = UIColor.gray.cgColor
        //        self.imageFromCameraRoll.layer.borderWidth = 1
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    //カメラロールボタンを押した時
    @IBAction func cameraRoll(sender: AnyObject) {
        self.pickImageFromLibrary()  //ライブラリから写真を選択する
        
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageFromCameraRoll.contentMode = .scaleAspectFit
            imageFromCameraRoll.image = pickedImage
            
            if info[UIImagePickerControllerOriginalImage] != nil {
                // 画像のパスを取得
                _ = info[UIImagePickerControllerReferenceURL] as? NSURL
            }
            
            //            let image = pickedImage
            //            let data = UIImageJPEGRepresentation(image, 0.9)
            //            data.writeToFile(imagePath, atomically: true)
            //            print("save: \(imagePath)")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL as NSURL
    }
    
    
    func fileInDocumentsDirectory(filename: String) -> String {
    
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        //pngで保存する場合
        let pngImageData = UIImagePNGRepresentation(image)
        // jpgで保存する場合
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        let result = pngImageData?.write(toFile: path, atomically: true)
        //    let result = pngImageData!.writeToFile(path, atomically: true)
        
        return result
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


