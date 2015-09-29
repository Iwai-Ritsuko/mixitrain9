//
//  TimelineEntity.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/6.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import Foundation
import CoreData

class TimelineEntity: NSManagedObject {

    @NSManaged var author: String
    @NSManaged var date: String
    @NSManaged var objectType: String
    @NSManaged var photoHeight: NSNumber
    @NSManaged var photoURL: String
    @NSManaged var text: String

}
