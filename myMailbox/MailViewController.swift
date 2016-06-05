//
//  MailViewController.swift
//  myMailbox
//
//  Created by Kelly Bryant on 6/4/16.
//  Copyright © 2016 Kelly Bryant. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var rescheduleView: UIView!
    @IBOutlet weak var archiveView: UIView!
    
    @IBOutlet weak var rescheduleIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    @IBOutlet weak var rescheduleOverlay: UIView!
    @IBOutlet weak var listOverlay: UIView!

    @IBOutlet weak var undoButton: UIButton!

    
    var messageOriginalCenter: CGPoint!
    var messageOn: CGPoint!
    
    //var rescheduleOriginal: CGPoint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedImage.image!.size
        
        // The onCustomPan
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        messageImage.userInteractionEnabled = true
        messageImage.addGestureRecognizer(panGestureRecognizer)
        

        messageOn = messageImage.center
        
        messageOriginalCenter = messageImage.center
        messageImage.center.x = 160
        
        rescheduleView.frame.origin = CGPoint(x: 320, y: 0)
        self.rescheduleView.backgroundColor = UIColor.grayColor()
        
        archiveView.frame.origin = CGPoint(x: -320, y: 0)
        self.archiveView.backgroundColor = UIColor.grayColor()
        
        archiveIcon.alpha = 0.25
        rescheduleIcon.alpha = 0.25
        listIcon.hidden = true
        deleteIcon.hidden = true
        
        rescheduleOverlay.hidden = true
        listOverlay.hidden = true
    
        
        // The onCustomTap: method will be defined in Step 3 below.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapRescheduleOverlay:")
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer.numberOfTapsRequired = 1;
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        rescheduleOverlay.userInteractionEnabled = true
        rescheduleOverlay.addGestureRecognizer(tapGestureRecognizer)
        
        // The onCustomTap: method will be defined in Step 3 below.
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: "tapListOverlay:")
        
        // Optionally set the number of required taps, e.g., 2 for a double click
        tapGestureRecognizer2.numberOfTapsRequired = 1;
        
        // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
        listOverlay.userInteractionEnabled = true
        listOverlay.addGestureRecognizer(tapGestureRecognizer2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//Setting up pan gesture recognizer

    func onCustomPan(sender: UIPanGestureRecognizer) {
        //var point = sender.locationInView(view)
        //var velocity = sender.velocityInView(view)
        var translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("Gesture began")
             messageOriginalCenter = messageImage.center
            
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            print("Gesture is changing")
            messageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            rescheduleView.frame.origin = CGPoint(x: 320 + translation.x, y: 0)
            archiveView.frame.origin = CGPoint(x: -320 + translation.x, y: 0)
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            print("Gesture ended")
            let velocity = sender.velocityInView(view)
            
            if velocity.x < 0{//move left
                print("left")

                if self.messageImage.frame.origin.x < 0  && self.messageImage.frame.origin.x > -60{
                    //change to gray
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.rescheduleView.backgroundColor = UIColor.grayColor()
                            self.rescheduleIcon.alpha = 1
                            self.messageImage.frame.origin.x = 0
                            self.rescheduleView.frame.origin.x = 320
                        }, completion: { (Bool) -> Void in
                    })
                }else if self.messageImage.frame.origin.x < -60 && self.messageImage.frame.origin.x > -260 {
                    //change to yellow
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.rescheduleView.backgroundColor = UIColor.yellowColor()
                            self.rescheduleIcon.alpha = 1
                            self.messageImage.frame.origin.x = -260
                            self.rescheduleView.frame.origin.x = 60
                        }, completion: { (Bool) -> Void in
                            print("open reschedule screen")
                            self.rescheduleOverlay.hidden = false
                    })
                    
                }else if self.messageImage.frame.origin.x < -260 && self.messageImage.frame.origin.x > -320{
                    //change to brown
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.rescheduleView.backgroundColor = UIColor.brownColor()
                            self.rescheduleIcon.hidden = true
                            self.listIcon.hidden = false
                            self.messageImage.frame.origin.x = -300
                            self.rescheduleView.frame.origin.x = 30
                        }, completion: { (Bool) -> Void in
                            print("opens list screen")
                            self.listOverlay.hidden = false
                    })
                }
                
                
            }else{//move right
                print("right")
                
                if self.messageImage.frame.origin.x > 0  && self.messageImage.frame.origin.x < 60{
                    //change to gray
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.archiveIcon.alpha = 1
                            self.archiveView.backgroundColor = UIColor.grayColor()
                            self.messageImage.frame.origin.x = 0
                            self.archiveView.frame.origin.x = -320
                        }, completion: { (Bool) -> Void in
//                           UIView.animateWithDuration(0.8, delay: 0.0,
//                               options: [], animations: { () -> Void in
//                            self.messageImage.frame.origin.x = 0
//                            self.archiveView.frame.origin.x = -320
//                            }
                    })
                }else if self.messageImage.frame.origin.x > 60 && self.messageImage.frame.origin.x < 260 {
                    //change to green
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.archiveView.backgroundColor = UIColor.greenColor()
                            self.archiveIcon.alpha = 1
                            self.messageImage.frame.origin.x = 260
                            self.archiveView.frame.origin.x = -60
                        }, completion: { (Bool) -> Void in
                            self.messageImage.hidden = true
                            self.archiveView.hidden = true
                            
                            UIView.animateWithDuration(0.8, delay: 0.0,
                                options: [], animations: { () -> Void in
                                    self.feedImage.frame.origin.y = self.feedImage.frame.origin.y - 94
                                }, completion: { (Bool) -> Void in
                            })
                    })
                    
                }else if self.messageImage.frame.origin.x > 260 && self.messageImage.frame.origin.x < 320{
                    //change to red
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            self.archiveView.backgroundColor = UIColor.redColor()
                            self.archiveIcon.hidden = true
                            self.deleteIcon.hidden = false
                            self.messageImage.frame.origin.x = 330
                            self.archiveView.frame.origin.x = -30
                        }, completion: { (Bool) -> Void in
                            self.messageImage.hidden = true
                            self.archiveView.hidden = true
                            
                            UIView.animateWithDuration(0.8, delay: 0.0,
                                options: [], animations: { () -> Void in
                                    self.feedImage.frame.origin.y = self.feedImage.frame.origin.y - 94
                                }, completion: { (Bool) -> Void in
                            })
                            
                    })
                }
                
            }
            
        
        
        }
        
        
        
        
    }


    @IBAction func tapRescheduleOverlay(sender: UITapGestureRecognizer) {
        print("did tap")
        rescheduleOverlay.hidden = true
        self.messageImage.hidden = true
        self.rescheduleView.hidden = true

        UIView.animateWithDuration(0.8, delay: 0.0,
            options: [], animations: { () -> Void in
                self.feedImage.frame.origin.y = self.feedImage.frame.origin.y - 94
            }, completion: { (Bool) -> Void in
       })
    }
    
    
    @IBAction func tapListOverlay(sender: UITapGestureRecognizer) {
        listOverlay.hidden = true
        self.messageImage.hidden = true
        self.rescheduleView.hidden = true
        
        UIView.animateWithDuration(0.8, delay: 0.0,
            options: [], animations: { () -> Void in
                self.feedImage.frame.origin.y = self.feedImage.frame.origin.y - 94
            }, completion: { (Bool) -> Void in
        })

    }
    

    
    
    @IBAction func undoButton(sender: AnyObject) {
        self.messageImage.frame.origin.x = 0
        self.rescheduleView.frame.origin.x = 320
        self.archiveView.frame.origin.x = -320
        
        
        //if self.messageImage.hidden == true{

            UIView.animateWithDuration(0.8, delay: 0.0,
                options: [], animations: { () -> Void in
                    //self.messageImage.frame.origin.x = 0
                    //self.rescheduleView.frame.origin.x = 320
                    self.messageImage.hidden = false
                    self.rescheduleView.hidden = false
                    self.archiveView.hidden = false
                    self.feedImage.frame.origin.y = self.feedImage.frame.origin.y + 94
                        }, completion: { (Bool) -> Void in
            })
       // }else if self.messageImage.hidden == false{
        
            
      //  }
            
        
    }


}
