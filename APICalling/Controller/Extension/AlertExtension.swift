//
//  AlertExtension.swift
//  APICalling
//
//  Created by TudipTech on 28/01/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: nil)
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
