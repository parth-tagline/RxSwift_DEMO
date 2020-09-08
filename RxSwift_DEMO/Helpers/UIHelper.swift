//
//  UIHelper.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 06/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import UIKit


class UIHelper {
    static func Alert(Title: String, Msg: String, vc: UIViewController) {
        let alert = UIAlertController(title: Title, message: Msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func courner_View(globeView: UIView, redius: CGFloat){
           globeView.layer.cornerRadius = redius
       }
    
    

}

