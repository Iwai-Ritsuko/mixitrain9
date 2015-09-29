//
//  PhotoCellHeightCalculator.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/3.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import UIKit

class PhotoCellHeightCalculator : NSObject {
    
    func calculateCellHeightWithEntity(entity : TimelineEntity) -> CGFloat {
        if entity.objectType == "photo" {
            return 80.0 + CGFloat(entity.photoHeight) + 20.0
        }
        return 0
    }
}
