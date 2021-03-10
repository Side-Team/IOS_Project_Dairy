//
//  AddContentViewController.swift
//  autoLayout_Test02
//
//  Created by MinWoo Lee on 2021/02/16.
//

import UIKit
import SQLite3

var selectedDate_AddContentView = ""
var selectedImage_AddContentView = ""

class AddContentViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var imgSelectedImage: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtViewContent: UITextView!
    
    // For connect SQLite3
    var db : OpaquePointer?
    
    // For check touch txtViewContent
    var touchSwitch = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTitle.delegate = self
        txtViewContent.delegate = self
        
        viewDesign()
        
        // Show date, image from previous views
        lblSelectedDate.text = selectedDate_AddContentView
        imgSelectedImage.image = UIImage(named: selectedImage_AddContentView)

        // Connect DB
        connectDB()

        viewDidLayoutSubviews()
    }
 
    // Button for DB insert action
    @IBAction func btnInsert(_ sender: UIButton) {
       checkNil()
    }
    
    // Exception handling when if don't type anything
    func checkNil(){
        if txtTitle.text?.isEmpty == true || txtViewContent.text?.isEmpty == true || touchSwitch == 0{
            showAlert(value : 0)
        }else{
            insertAction()
        }
    }
    
    // DB insert action
    func insertAction(){
        
        var stmt : OpaquePointer?
        let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
        
        let cTitle = txtTitle.text!
        let cContent = txtViewContent.text!
        let cImageFileName = selectedImage_AddContentView
        let cInsertDate = selectedDate_AddContentView
        
        let queryString = "INSERT INTO contents (cTitle, cContent, cImageFileName, cInsertDate) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert : \(errmsg)")
            showAlert(value: 2)
            return
        }
        
        if sqlite3_bind_text(stmt, 1, cTitle, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding Title : \(errmsg)")
            showAlert(value: 2)
            return
        }
        
        if sqlite3_bind_text(stmt, 2, cContent, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding Content : \(errmsg)")
            showAlert(value: 2)
            return
        }
        
        if sqlite3_bind_text(stmt, 3, cImageFileName, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding ImageFileName : \(errmsg)")
            showAlert(value: 2)
            return
        }
        
        if sqlite3_bind_text(stmt, 4, cInsertDate, -1, SQLITE_TRANSIENT) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error binding InsertDate : \(errmsg)")
            showAlert(value: 2)
            return
        }
       
        if sqlite3_step(stmt) != SQLITE_DONE{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting : \(errmsg)")
            return
        }
        
        showAlert(value: 1)
        
        
        
    }
    
    // Show Alert
    func showAlert(value : Int){
        let alert : UIAlertController
        var okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
            self.navigationController?.popToRootViewController(animated: true)
        })

        if value == 0{
            alert = UIAlertController(title: "알림", message: "빈칸없이 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        }else if value == 1{
            alert = UIAlertController(title: "등록 성공!", message: "글 등록이 완료되었습니다.", preferredStyle: UIAlertController.Style.alert)
        }else{
            alert = UIAlertController(title: "등록 실패!", message: "오류가 발생했습니다.", preferredStyle: UIAlertController.Style.alert)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Connect DB(SQLite3)
    func connectDB(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("MyDiaryData.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
        }
    }
    
    // Lower keyboard when click outside click
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
   }
    
    // Design view
    func viewDesign(){
        txtViewContent.layer.borderWidth = 1
        txtViewContent.layer.borderColor = UIColor.lightGray.cgColor
        txtViewContent.layer.cornerRadius = 10
        txtViewContent.text = changePlaceholder()
        txtViewContent.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    // TextView placeholder
    func textViewSetupView(){
        let placeholder = changePlaceholder()
        
        if txtViewContent.text == placeholder{
            
            txtViewContent.textColor = UIColor.black
            txtViewContent.text = ""
        }else if txtViewContent.text == ""{
            
            txtViewContent.textColor = UIColor.lightGray
            txtViewContent.text = placeholder
        }
    }

    // Start edit
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textViewSetupView()
    }
    
    // End edit
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtViewContent.text == ""{
            textViewSetupView()
            touchSwitch = 0
        }else{
            touchSwitch = 1
        }
    }
    
    // Editing
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            txtViewContent.resignFirstResponder()
        }
        return true
    }
    
    // Check current time for changePlaceholder
    func getCurrentTime() -> (Int, String){
        let date = NSDate()
        let formatter = DateFormatter()
    
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "HHmm"
        
        let currentTime = Int(formatter.string(from: date as Date))
        
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "YYYY-MM-dd"
        
        let currentDate = formatter.string(from: date as Date)

        return (currentTime!, currentDate)
    }
    
    // For change placeholder on txtViewContent
    func changePlaceholder() -> String{
        let currentTime = getCurrentTime().0
        
        
        
        if getCurrentTime().1 == selectedDate_AddContentView{
            if currentTime >= 600 && currentTime < 1200{
                return "좋은 아침입니다! 잠은 푹 잤나요?"
            }else if currentTime >= 1200 && currentTime < 1800{
                return "오늘 먹은 점심메뉴는 뭐였어요?"
            }else if currentTime >= 1800 && currentTime < 2400{
                return "저녁에는 뭐 할거에요?"
            }else{
                return "감성 돋는 새벽에는 다이어리 쓰기 좋을 거 같네요!"
            }
        }else{
            return "\(selectedDate_AddContentView) 에는 어떤 일이 있었나요?"
        }
        
    }

    // Add underline to title
    override func viewDidLayoutSubviews() {
        txtTitle.borderStyle = .none
                let border = CALayer()
        border.frame = CGRect(x: 0,
        y: txtTitle.frame.size.height-1,
        width: txtTitle.frame.width,
            height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        txtTitle.layer.addSublayer((border))
        txtTitle.textAlignment = .center
        txtTitle.textColor = UIColor.black
        
    }
    
    // to limit maximum input characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = txtTitle.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 15
    }
}
