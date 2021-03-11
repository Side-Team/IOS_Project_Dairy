//
//  CheckPWViewController.swift
//  MyDiary
//
//  Created by MinWoo Lee on 2021/02/18.
//

import UIKit
import SwiftSMTP

class CheckPWViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var outlet_BtnCheck: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    
    // Variable to get today's date
    let today = NSDate()
    let dateFormatter = DateFormatter()
 
    // Variable to count incorrect password count
    var incorrectPWCount = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    // Button for check correct password when user input password
    @IBAction func btnCheck(_ sender: UIButton) {
      
        if incorrectPWCount > 5{
            emailAuth()
        }else{
            let alert = UIAlertController(title: "알림", message: "정확한 비밀번호를 입력해주세요. (\(incorrectPWCount)/5)", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            let password = UserDefaults.standard.string(forKey: "password")!
            
            // Exception handling when don't type anything
            if txtPassword.text!.isEmpty {
                incorrectPWCount += 1
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }else{
                
                // When type correct password
                if password == txtPassword.text!{
                    let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                    vcName?.modalPresentationStyle = .fullScreen
                    self.present(vcName!, animated: true, completion: nil)
                    
                }else{
                    txtPassword.text = ""
                    incorrectPWCount += 1
                    alert.addAction(okAction)
                    present(alert, animated: true, completion: nil)
                }
            }
        }
        
        if incorrectPWCount > 5{
            lblTitle.text = "입력이 제한되었습니다"
            lblTitle.textColor = .red
            txtPassword.isEnabled = false
            outlet_BtnCheck.setTitle("비밀번호 삭제", for: .normal)
        }
    }
    
    // Email authentication required to find password
    func emailAuth(){
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: today as Date)
        
        if UserDefaults.standard.string(forKey: "date") != nil && UserDefaults.standard.string(forKey: "date") != dateString{

            UserDefaults.standard.set(0, forKey: "authEmailCount")
            UserDefaults.standard.set(dateString, forKey: "date")
        }
        
        if UserDefaults.standard.integer(forKey: "authEmailCount") >= 3{
            resultMsg(title: "인증 제한", message: "하루 최대 인증 횟수를 초과하여 기능이 제한됩니다.")
            
        }else{
            let authValue = randomStr(5)
            
            sendEmail(userEmail: UserDefaults.standard.string(forKey: "authEmail")!, authValue: authValue)
            
            let secondAlert = UIAlertController(title: "인증번호 확인", message: "\(hideEmail())로 인증번호를 발송했습니다.\n인증은 하루 3번만 가능합니다.\n(\(UserDefaults.standard.integer(forKey: "authEmailCount") + 1)/3)", preferredStyle: UIAlertController.Style.alert)
            secondAlert.addTextField { (secondTextField) in
            secondTextField.textAlignment = .center
            }
            let doneAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {[self]ACTION in
                if secondAlert.textFields![0].text! != authValue{
                    
                    switch  UserDefaults.standard.integer(forKey: "authEmailCount"){
          
                    case 1:
                        UserDefaults.standard.set(2, forKey: "authEmailCount")
                    case 2:
                        UserDefaults.standard.set(3, forKey: "authEmailCount")
                        UserDefaults.standard.set(dateString, forKey: "date")
                    case 3:
                        UserDefaults.standard.set(4, forKey: "authEmailCount")
                    default:
                        UserDefaults.standard.set(1, forKey: "authEmailCount")
                        break
                    }
                    resultMsg(title: "인증 실패", message: "잘못된 인증번호입니다.")
                }else{
                    resultMsg(title: "인증 성공", message: "비밀번호가 삭제되었습니다.")
                }
            })
            secondAlert.addAction(doneAction)
            present(secondAlert, animated: true, completion: nil)
        }
    }
    
    
    // Shows authentication results
    func resultMsg(title : String, message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        var okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)

        if title == "인증 성공"{
            okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: {ACTION in
                
                UserDefaults.standard.set("false", forKey: "switchValue")
                UserDefaults.standard.set(nil, forKey: "password")
                
                let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                vcName?.modalPresentationStyle = .fullScreen
                self.present(vcName!, animated: true, completion: nil)
            })
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // The function that sends the email
    func sendEmail(userEmail : String, authValue : String){
        
        let smtp = SMTP(
            hostname: "smtp.gmail.com",
            email: "ssdam.auth@gmail.com",
            password: "ssdam1111"
        )

        let mail_from = Mail.User(name: "쓰담", email: "ssdam.auth@gmail.com")
        let mail_to = Mail.User(name: "", email: userEmail)

        let mail = Mail(
            from: mail_from,
            to: [mail_to],
            subject: "<쓰담> 인증번호입니다",
            text: "인증번호 : \(authValue)"
        )
        
        smtp.send(mail){ (error) in
            if let error = error {
                print(error)
            }
        }
    }
    
    // Generate Authentication Number
    func randomStr(_ number : Int) -> String{
        let strTemp = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numTemp = "1234567890"

        var str = ""

        for _ in 0..<number{
            let randomNum1 = Int(arc4random_uniform(UInt32(strTemp.count)))
            let randomNum2 = Int(arc4random_uniform(UInt32(numTemp.count)))
            
            str += String(strTemp[strTemp.index(strTemp.startIndex, offsetBy: randomNum1)])
            str += String(numTemp[numTemp.index(numTemp.startIndex, offsetBy: randomNum2)])
        }
        return str
    }
    
    // Hide email address as special characters
    func hideEmail() -> String {
        var authEmail = UserDefaults.standard.string(forKey: "authEmail")!.map { String($0) }
        let index = authEmail.lastIndex(of: "@")
        
        if index! > 3{
            for i in index!-2...index!{
                authEmail[authEmail.index(before: i)] = "*"
            }
        }
        return authEmail.joined()
    }

}
