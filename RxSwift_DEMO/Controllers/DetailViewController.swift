//
//  DetailViewController.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit
import SwiftSpinner

class DetailViewController: UIViewController {

    @IBOutlet var view_subview: UIView!
    @IBOutlet var lbl_title: UILabel!
    @IBOutlet var lbl_titleValue: UILabel!
    @IBOutlet var lbl_description: UILabel!
    @IBOutlet var txt_descriptionValue: UITextView!
    @IBOutlet var btn_save: UIButton!
    
    var detailData = NoteData.init(id: "id", title: "title", content: "content", date: "")
    var db:DBHelper = DBHelper()
       var _notedata:[NoteData] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setData()
        setFont()
       setLayout()
        setNavigation()
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let BackButton = UIBarButtonItem(image: UIImage(named: "back-icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backAction))
        self.navigationItem.leftBarButtonItem  = BackButton
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.title = self.detailData.title
    }
    
    @objc func backAction() {
               self.navigationController?.popViewController(animated: true)
           }
    
    func setData(){
        self.txt_descriptionValue.isEditable = true
        print("detailData ",detailData.id)
        self.lbl_title.text = AppString.diaryTitle
        self.lbl_description.text = AppString.diaryContent
        self.lbl_titleValue.text = self.detailData.title
        self.txt_descriptionValue.text = self.detailData.content
    }
    
    
    func setLayout(){
        self.lbl_title.textColor = AppColor.titleColor
        self.lbl_titleValue.textColor = AppColor.App_Grey_Primary
        self.txt_descriptionValue.textColor = AppColor.App_Grey_Primary
        self.lbl_description.textColor = AppColor.titleColor
        self.btn_save.backgroundColor = AppColor.Web_Branding_Primary
        self.btn_save.setTitle(AppButtons.save, for: .normal)
        self.btn_save.tintColor = AppColor.white
        UIHelper.courner_View(globeView: self.btn_save, redius: 5)
    }
    
    func setFont(){
        self.lbl_title.font = AppFont.systemFont(fontSize: 12, weight: 600)
        self.lbl_description.font = AppFont.systemFont(fontSize: 12, weight: 600)
        self.lbl_titleValue.font = AppFont.systemFont(fontSize: 15, weight: 600)
        self.txt_descriptionValue.font = AppFont.systemFont(fontSize: 15, weight: 100)
    }
    
    

    // MARK: - Navigation

    @IBAction func btn_save_tapped(_ sender: Any) {
        if (self.txt_descriptionValue.text != ""){
           
            db.update(id: detailData.id, title: detailData.title, content: self.txt_descriptionValue.text)
            _notedata = db.read()
        }else{
            UIHelper.Alert(Title: DefaultKeys.error, Msg: DefaultKeys.emptyfields, vc: self)
        }
    }
}
