//
//  ViewController.swift
//  APICalling
//
//  Created by TudipTech on 27/01/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let model: LoginModel = LoginModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login".localized
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.usernamePasswordValidation()
    }
}
extension ViewController {
    func hideKeyboardWhenTappedAround() {
           let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
    
    func usernamePasswordValidation() {

        if let email = userNameTextField.text, let password = passwordTextField.text {
            let message = model.validateLogin(email: email, password: password)
            if !message.isEmpty {
                openAlert(title: "Alert", message: message, alertStyle: .alert, actionTitles: ["OK"], actionStyles: [.default])
            } else {
                guard let structVCObj = storyboard?.instantiateViewController(identifier: "structViewController") as? structViewController else {
                    return
                }
                self.navigationController?.pushViewController(structVCObj, animated: true)
            }
        }
    }
}

