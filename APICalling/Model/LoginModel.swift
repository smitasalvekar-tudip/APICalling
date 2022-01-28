//
//  LoginModel.swift
//  APICalling
//
//  Created by TudipTech on 28/01/22.
//

import Foundation
class LoginModel {
    func validateLogin(email: String, password: String) -> String {

        if email.isEmpty {
            return "Blank_Email".localized
        } else if !email.validateEmailId() {
            return "Invalid_Email".localized
        } else if password.isEmpty {
            return "Blank_Password".localized
        } else if !password.validatePassword() {
            return "Invalid_Password".localized
        }
        return ""
    }
}
