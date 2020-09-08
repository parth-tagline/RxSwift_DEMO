//
//  Constants.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import Foundation
import UIKit


typealias KeyValue  =  [String : Any]

struct AppColor {
    static let App_Grey_Primary =  UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)
    static let App_Grey_Secondary =  UIColor(red: 0.45, green: 0.47, blue: 0.51, alpha: 1.00)
    static let Web_Branding_Primary =  UIColor(red: 0.27, green: 0.13, blue: 0.64, alpha: 1.00)
    static let App_Grey_Soft =  UIColor(red: 0.75, green: 0.76, blue: 0.76, alpha: 1.00)
    static let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let titleColor = UIColor(red: 0.60, green: 0.62, blue: 0.65, alpha: 1.00)
}

struct AppString {
    static let navTitle  = "My Diary"
    static let diaryTitle = "Diary Title"
    static let diaryContent = "Diary Content"
}

struct AppUrls {
    static let getNotes  = "https://private-ba0842-gary23.apiary-mock.com/notes"
}

struct AppPlaceHolders {
    
}

struct AppButtons {
    static let save                = "SAVE"
    static let edit                = "EDIT"
}

struct DefaultKeys {
    static let isContactAdd              = "isContactAdd"
    static let isContactEdit             = "isContacttAdd"
    static let isContacttDelete          = "isContacttDelete"
    static let emailError                = "Please enter a velid Email address"
    static let error                     = "ERROR"
    static let emptyfields               = "Please fill name and email"
}

struct Storyboards {
    static let mainStoryboard  = UIStoryboard.init(name: "Main", bundle: Bundle.main)
}

struct AppFont {
    
    static func systemFont(fontSize: CGFloat , weight : UIFont.Weight.RawValue) -> UIFont {
//        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: weight))
        return UIFont.systemFont(ofSize: fontSize)
    }
}

struct Device {
    static let height = UIScreen.main.bounds.size.height
    static let width = UIScreen.main.bounds.size.width
    static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
}


class DateHelper{
    static func StringConvertToDate(date : String) -> Date{
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm MM-dd-yyyy"
//        let data = dateFormatter.date(from:"2020-07-09T15:42:30+0000")
        let date1 = dateFormatter.date(from: date)
        return date1 ?? Date()
    }
}
