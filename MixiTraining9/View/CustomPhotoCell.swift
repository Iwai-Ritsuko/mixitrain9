//
//  CustomPhotoCell.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/3.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import UIKit

@objc protocol customPhotoCellDelegate {
    optional func imageDidGet()
}

class CustomPhotoCell : CustomCell {
    @IBOutlet weak var photoView : UIImageView!
    
    var delegate : customPhotoCellDelegate?
    
    override func setCellContentsWithEntity(entity: TimelineEntity) {
        
        self.authorLabel.text = entity.author
        self.dateLabel.text = entity.date
        
        var imageRequest : NSURLRequest = NSURLRequest(URL: NSURL(string: entity.photoURL)!)
        NSURLConnection.sendAsynchronousRequest(imageRequest, queue: NSOperationQueue(), completionHandler: self.getImage)
    }
    
    func getImage(res:NSURLResponse?,data:NSData?,error:NSError?) {
        self.photoView!.image = UIImage(data: data!)
        self.delegate?.imageDidGet?()
    }
}
