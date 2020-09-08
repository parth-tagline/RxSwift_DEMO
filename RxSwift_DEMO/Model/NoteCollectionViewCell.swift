//
//  NoteCollectionViewCell.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell{

    
    @IBOutlet weak var cell_mainview: UIView!
    @IBOutlet weak var cell_subview: UIView!
    @IBOutlet weak var cell_titlelbl: UILabel!
    @IBOutlet weak var cell_editbtn: UIButton!
    @IBOutlet weak var cell_description: UITextView!
    @IBOutlet weak var cell_datelbl: UILabel!
    
    @IBOutlet weak var cell_date: UILabel!
    
    @IBOutlet weak var cell_btn_remove: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        setLayout()
        setFont()
        self.cell_description.sizeToFit()
        
    }
    @IBAction func btn_close_tapped(_ sender: Any) {
        print("CLOSE BUTTION TAPPED")
    }
    
    func setLayout(){
        self.cell_titlelbl.textColor = AppColor.App_Grey_Primary
        self.cell_description.textColor = AppColor.App_Grey_Secondary
        self.cell_datelbl.textColor = AppColor.App_Grey_Soft
        self.cell_editbtn.setTitle(AppButtons.edit, for: .normal)
        self.cell_editbtn.tintColor = AppColor.Web_Branding_Primary
    }
    
    func setFont(){
        self.cell_titlelbl.font = AppFont.systemFont(fontSize: 15, weight: 600)
        self.cell_description.font = AppFont.systemFont(fontSize: 14, weight: 600)
        self.cell_datelbl.font = AppFont.systemFont(fontSize: 14, weight: 100)
    }

}
