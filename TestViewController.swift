//
//  TestViewController.swift
//  myMailbox
//
//  Created by Kelly Bryant on 6/4/16.
//  Copyright © 2016 Kelly Bryant. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {


    @IBOutlet weak var rescheduleView: UIView!

    @IBOutlet weak var archiveView: UIView!
    @IBOutlet weak var messageImage: UIImageView!
    
    var messageOriginalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    
    var messageRightOffset: CGFloat!
    var messageLeftOffset: CGFloat!
    
    var rescheduleOriginal: CGPoint!
    var rescheduleViewOffset: CGFloat!
   
    var archiveOriginal: CGPoint!
    var archiveViewOffset: CGFloat!
    
    
   // var trayOriginalCenter: CGPoint!

   // var trayDownOffset: CGFloat!
   // var trayUp: CGPoint!
   // var trayDown: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //messageRightOffset = 100
        //messageLeftOffset = -100

        
        archiveViewOffset = -320
        rescheduleViewOffset = 320
        
        archiveView.frame.origin.x = archiveViewOffset
        rescheduleView.frame.origin.x = rescheduleViewOffset
        
        //trayDownOffset = 160
        //trayUp = trayView.center
        //trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanMessage(sender: AnyObject) {
        let translation = sender.translationInView(view)

        
        if sender.state == UIGestureRecognizerState.Began {
            //trayOriginalCenter = trayView.center
            messageOriginalCenter = messageImage.center

        } else if sender.state == UIGestureRecognizerState.Changed {
            //trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            messageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            //archiveView.center = CGPoint(x: archiveOriginal.x + translation.x, y: archiveOriginal.y)
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            let velocity = sender.velocityInView(view)
        
            if velocity.x > 0{
                print("right, archive")
                //put reschedule back
                //self.rescheduleView.frame.origin.x = 320
                
                //move right
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    //move message
                    self.messageImage.center = CGPoint(x: self.messageImage.center.x + translation.x, y: self.messageImage.center.y)
                    //move archive view
                    self.archiveView.center = CGPoint(x: self.archiveView.center.x + translation.x, y: self.archiveView.center.y)
                    
                    }, completion: { (Bool) -> Void in
                })
                
            }else{
                print("moving left")
                //put archive back
              //  self.archiveView.frame.origin.x = -320
                
                UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
                    //move message
                    self.messageImage.center = CGPoint(x: self.messageImage.center.x + translation.x, y: self.messageImage.center.y)
                    //move reschedule view
                     self.rescheduleView.center = CGPoint(x: self.rescheduleView.center.x + translation.x, y: self.rescheduleView.center.y)


                    }, completion: { (Bool) -> Void in
                })
            }
            //} else if sender.state == UIGestureRecognizerState.Ended {
        }
        
    }

}
