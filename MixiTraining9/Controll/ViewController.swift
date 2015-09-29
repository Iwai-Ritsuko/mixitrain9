//
//  ViewController.swift
//  MixiTraining9
//
//  Created by Iwai Ritsuko on 2015/8/3.
//  Copyright (c) 2015年 RiccaLokka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, timelineModelManagerDelegate, customPhotoCellDelegate {
    
    @IBOutlet weak var timelineTableView: UITableView!
    @IBOutlet weak var loadingView : UIView!
    @IBOutlet weak var connectionFaildLabel : UILabel!
    
    var tModel : TimelineModelManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tModel = TimelineModelManager()
        tModel!.delegate = self
        
        tModel!.fetchTimelineData()
        
        // TableView Cell Height Controll
        timelineTableView.rowHeight = UITableViewAutomaticDimension;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:- TimelineModelManagerDelegate methods
    func timelineModelDidFailLoad() {
        self.loadingView.removeFromSuperview()
        self.connectionFaildLabel.hidden = false
        self.connectionFaildLabel.alpha = 0.0
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in self.connectionFaildLabel.alpha = 1.0}, completion: {(Bool) -> Void in self.hideConnectionFailedLabel()
        })
    }
    
    func timelineModelDidFinishLoad() {
        self.timelineTableView.reloadData()
        self.loadingView.removeFromSuperview()
        
        self.timelineTableView.reloadData()
    }
    
    func hideConnectionFailedLabel() {
        UIView.animateWithDuration(
            0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.AllowAnimatedContent,
            animations: {
                self.connectionFaildLabel.alpha = 0.0
            },
            completion: {
                (value: Bool) in
                self.connectionFaildLabel.hidden = true
        })
    }
    
    // MARK: - UITableViewDatasource Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tModel!.tlArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let entity : TimelineEntity = tModel!.tlArray[indexPath.row]
        var cell : CustomCell
        if entity.objectType == "text" {
            cell = tableView.dequeueReusableCellWithIdentifier(entity.objectType) as! CustomTextCell
            
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier(entity.objectType) as! CustomPhotoCell
        }
        cell.setCellContentsWithEntity(entity)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let entity : TimelineEntity = tModel!.tlArray[indexPath.row]
        if entity.objectType == "photo" {
            return PhotoCellHeightCalculator().calculateCellHeightWithEntity(entity)
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

