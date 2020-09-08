//
//  NoteHeaderReusableView.swift
//  RxSwift_DEMO
//
//  Created by tagline13 on 05/09/20.
//  Copyright © 2020 tagline13. All rights reserved.
//

import UIKit

class NoteHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var cellHeader_mainview: UIView!
    @IBOutlet weak var cellHeader_subview: UIView!
    @IBOutlet weak var cellHeader_timeimg: UIImageView!
    @IBOutlet weak var cellHeader_daylbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
