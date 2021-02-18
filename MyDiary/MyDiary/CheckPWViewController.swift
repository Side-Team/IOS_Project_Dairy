//
//  CheckPWViewController.swift
//  MyDiary
//
//  Created by 이민우 on 2021/02/18.
//

import UIKit

class CheckPWViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCheck(_ sender: UIButton) {
        let alert = UIAlertController(title: "알림", message: "올바른 비밀번호를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
        let password = UserDefaults.standard.string(forKey: "password")!
        
        // Exception handling when don't type anything
        if txtPassword.text!.isEmpty {
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else{
            
            // When type correct password
            if password == txtPassword.text!{
                let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MainView")
                vcName?.modalPresentationStyle = .fullScreen
                self.present(vcName!, animated: true, completion: nil)
                
            }else{
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
