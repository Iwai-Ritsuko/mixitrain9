//
//  customTextCell.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/3.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import UIKit

class CustomTextCell : CustomCell {
    @IBOutlet weak var mainTextLabel: UILabel!
    
    override func setCellContentsWithEntity(entity: TimelineEntity) {
        self.authorLabel.text = entity.author
        self.dateLabel.text = entity.date
        
        self.mainTextLabel.text = entity.text
        self.mainTextLabel.sizeToFit()
    }
}
