//
//  TimeLineModelManager.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/3.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import UIKit
import CoreData

@objc protocol timelineModelManagerDelegate {
    optional func timelineModelDidFailLoad()
    optional func timelineModelDidFinishLoad()
}

class TimelineModelManager {
    var delegate : timelineModelManagerDelegate?
    var tlArray = [TimelineEntity]()
    
    func fetchTimelineData() {
        
        var myRequest : NSURLRequest = NSURLRequest(URL: NSURL(string: "https://raw.github.com/mixi-inc/iOSTraining/master/SampleData/9.3/timeline.json")!)
        var backgroundQueue : NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(myRequest, queue: backgroundQueue, completionHandler: self.getHttp)
        
    }
    
    func getHttp(res:NSURLResponse?, data:NSData?, error:NSError?) {
        // convert data to String
        var myData:NSString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
        
        if error != nil {
            NSOperationQueue().addOperationWithBlock({ () -> Void in
                self.delegate?.timelineModelDidFailLoad?()
            })
            return
        }
        
        let dataArray : NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSArray
        
        for dict in dataArray {
            let context : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
            let entity : NSEntityDescription! = NSEntityDescription.entityForName("TimelineEntity", inManagedObjectContext: context)
            let timeLineModel = TimelineEntity(entity: entity, insertIntoManagedObjectContext: context)
            timeLineModel.author = dict["author"] as! String
            timeLineModel.date = dict["date"] as! String
            timeLineModel.objectType = dict["object_type"] as! String
            
            if let t = dict["text"] as? String {
                timeLineModel.text = t
            }
            
            if let p = dict["photo_url"] as? String {
                timeLineModel.photoURL = p
                timeLineModel.photoHeight = dict["photo_height"] as! NSNumber
            }
            
            tlArray.append(timeLineModel)
            context.save(nil)
        }
        
        NSOperationQueue.mainQueue().addOperationWithBlock(
            { () -> Void in
                self.delegate?.timelineModelDidFinishLoad?()
        })
    }
}
