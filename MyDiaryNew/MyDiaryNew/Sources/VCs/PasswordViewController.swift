//
//  PasswordViewController.swift
//  MyDiary
//
//  Created by MinWoo Lee on 2021/02/18.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var outlet_BtnUpdateEmailAddress: UIBarButtonItem!
    @IBOutlet weak var swOnOff: UISwitch!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnUpdate: UIButton!
    
    // Store when user input password
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {        
        checkSwitchValue()
        constraintSwitch()

    }

    // Switch for using password lock
    @IBAction func swChangeOnOff(_ sender: UISwitch) {
        constraintSwitch()
    }
    
    // Button for changing email address
    @IBAction func btnUpdateEmailAddress(_ sender: UIBarButtonItem) {
        
        if UserDefaults.standard.string(forKey: "password") == nil{
            let alert = UIAlertController(title: "알림", message: "먼저 비밀번호를 등록해주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "비밀번호 확인", message: "비밀번호를 입력해주세요", preferredStyle: UIAlertController.Style.alert)
            alert.addTextField { (myTextField) in
            myTextField.textAlignment = .center
            myTextField.keyboardType = .numberPad
            myTextField.isSecureTextEntry = true
            }
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { [self]ACTION in
                if alert.textFields![0].text! != UserDefaults.standard.string(forKey: "password"){
                    let failAlert = UIAlertController(title: "알림", message: "등록된 비밀번호가 아닙니다.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                    
                    failAlert.addAction(okAction)
                    present(failAlert, animated: true, completion: nil)
                }else{
                    registerEmail()
                }
            })
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Button when change password
    @IBAction func btnUpdatePassword(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: "authEmail") == nil{
            registerEmail()
        }else{
            if UserDefaults.standard.string(forKey: "password") != nil{
                let alert = UIAlertController(title: "비밀번호 확인", message: "기존 비밀번호를 입력해주세요", preferredStyle: UIAlertController.Style.alert)
                alert.addTextField(configurationHandler: {(myTextField) in
                myTextField.keyboardType = .numberPad
                myTextField.isSecureTextEntry = true
                })
                let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {[self]ACTION in
                    if UserDefaults.standard.string(forKey: "password") != alert.textFields![0].text!{
                        let failAlert = UIAlertController(title: "알림", message: "등록된 비밀번호와 다릅니다.", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                
                        failAlert.addAction(okAction)
                        present(failAlert, animated: true, completion: nil)
                    }else{
                        checkPassword()
                    }
                })
                let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true, completion: nil)
            }else{
                checkPassword()
            }
        }
        
    }
    
    // to limit minimum and maximum input characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 8
    }
    
    // Lower keyboard when click outside click
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
         self.view.endEditing(true)
    }
    
    // Exception handling for incorrect password
    func checkPassword(){
        var alert = UIAlertController(title: "알림", message: "4~8글자의 비밀번호를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        var okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { [self]ACTION in
            txtPassword.text = ""
        })
        
        if txtPassword.text!.isEmpty == true{
            
        }else if txtPassword.text!.count >= 4 && txtPassword.text!.count <= 8{
            if UserDefaults.standard.string(forKey: "password") != nil{
                alert = UIAlertController(title: "알림", message: "비밀번호가 수정되었습니다.", preferredStyle: UIAlertController.Style.alert)
            }else{
                alert = UIAlertController(title: "알림", message: "비밀번호가 설정되었습니다.", preferredStyle: UIAlertController.Style.alert)
                UserDefaults.standard.set("true", forKey: "switchValue")
            }
            okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
            })
            UserDefaults.standard.set(self.txtPassword.text!, forKey: "password")
            
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    // For constraint when on and off switch
    func constraintSwitch(){
        if swOnOff.isOn == false{
            UserDefaults.standard.set("false", forKey: "switchValue")
            txtPassword.isEnabled = false
            txtPassword.placeholder = ""
            btnUpdate.isEnabled = false
            lblText.text = "비밀번호 OFF"
        }else{
            if UserDefaults.standard.string(forKey: "password") != nil {
                
                UserDefaults.standard.set("true", forKey: "switchValue")
                txtPassword.isEnabled = true
                btnUpdate.isEnabled = true
                lblText.text = "비밀번호 ON"
            }else{
                txtPassword.isEnabled = true
                btnUpdate.isEnabled = true
                lblText.text = "비밀번호를 입력해주세요\n(4자리 ~ 8자리)"
                
                if UserDefaults.standard.string(forKey: "authEmail") == nil{
                    outlet_BtnUpdateEmailAddress.isEnabled = false
                    lblText.textColor = .lightGray
                    let attributedStr = NSMutableAttributedString(string: "등록버튼을 눌러 이메일을 입력해주세요")
                    attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: ("등록버튼을 눌러 이메일을 입력해주세요" as NSString).range(of: "등록"))
                    
                    lblText.attributedText = attributedStr
                    txtPassword.isEnabled = false
                }
                
            }
        }
        
        
    }
    
    // Check value when switch on and off
    func checkSwitchValue(){
        if let switchValue = UserDefaults.standard.string(forKey: "switchValue"){
            
            if switchValue == "true"{
                swOnOff.isOn = true
            }else{
                swOnOff.isOn = false
            }
        }
    }
    
    // Email settings to receive authentication mail
    func registerEmail(){
        
        let alert = UIAlertController(title: "이메일 확인", message: "인증번호를 받을 이메일을 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (myTextField) in
        myTextField.placeholder = "ex)ssdam@naver.com"
        myTextField.textAlignment = .center
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {[self]ACTION in
            
            let result = isValidEmail(testStr: alert.textFields![0].text!)
            
            if result != true{
                let invalidEmailAlert = UIAlertController(title: "이메일 형식 오류", message: "유효하지 않은 이메일 형식입니다.\n다시 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {[self]ACTION in
                    registerEmail()
                })
                
                invalidEmailAlert.addAction(okAction)
                present(invalidEmailAlert, animated: true, completion: nil)
            }else{
                
                let okAlert = UIAlertController(title: "이메일 설정 성공", message: "\(alert.textFields![0].text!)\n이메일이 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {[self]ACTION in
                    outlet_BtnUpdateEmailAddress.isEnabled = true
                    txtPassword.isEnabled = true
                    txtPassword.placeholder = ""
                    
                    if UserDefaults.standard.string(forKey: "password") == nil{
                        lblText.text = "비밀번호를 등록해주세요\n(4자리 ~ 8자리)"
                    }
                    lblText.textColor = .black
                })
                
                UserDefaults.standard.set(alert.textFields![0].text!, forKey: "authEmail")
           
                okAlert.addAction(okAction)
                present(okAlert, animated: true, completion: nil)
            }
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Verify that this is a valid email format
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
