//
//  MailboxViewController.swift
//  myMailbox
//
//  Created by Kelly Bryant on 5/31/16.
//  Copyright © 2016 Kelly Bryant. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    
    @IBOutlet weak var messageImage: UIImageView!
    
    @IBOutlet weak var rescheduleListView: UIView!
    @IBOutlet weak var laterImage: UIImageView!
   
    @IBOutlet weak var archiveView: UIView!
    @IBOutlet weak var archiveImage: UIImageView!
    
    
    var messageOriginalCenter: CGPoint!
    var messageOn: CGPoint!
    
    var rescheduleOriginal: CGPoint!
    var rescheduleOn: CGPoint!
    
    var xLeftOff: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.contentSize = feedView.image!.size
 
        messageOn = messageImage.center
        
        messageOriginalCenter = messageImage.center
        messageImage.center.x = 160

        rescheduleListView.frame.origin.x = 320
        archiveView.frame.origin.x = -320
        
        xLeftOff = 0
        
        self.archiveView.backgroundColor = UIColor.grayColor()
        self.rescheduleListView.backgroundColor = UIColor.grayColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func onCustomPan(sender: UIPanGestureRecognizer) {
        var translation = sender.translationInView(view)
        print("didpan translation: \(translation.x)")
        
        if sender.state == UIGestureRecognizerState.Began {
            //trayOriginalCenter = trayView.center
            messageOriginalCenter = messageImage.center
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageImage.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            rescheduleListView.frame.origin = CGPoint(x: 320 + translation.x, y: 0)
            archiveView.frame.origin = CGPoint(x: -320 + translation.x, y: 0)
            
            
            
        
        }else if sender.state == UIGestureRecognizerState.Ended {

            let velocity = sender.velocityInView(view)

            //move right
            if velocity.x > 0{
                //put away left side
                print("in velocity")
            
//                if messageImage.frame.origin.x > 0 && messageImage.frame.origin.x < 60{
//                UIView.animateWithDuration(0.8, delay: 0.0,
//                    options: [], animations: { () -> Void in
//                        
//                        self.messageImage.frame.origin.x = 0
//                        //self.rescheduleListView.frame.origin.x = 360
//                        
//                        //print("reset color")
//                        //self.rescheduleListView.backgroundColor = UIColor.grayColor()
//                        //self.archiveView.backgroundColor = UIColor.grayColor()
//            
//                        
//                    }, completion: { (Bool) -> Void in
//                        print("reset color2")
//                        //self.rescheduleListView.backgroundColor = UIColor.grayColor()
//                        //self.archiveView.backgroundColor = UIColor.grayColor()
//                    })
//                }else{
            
                    if self.messageImage.frame.origin.x > 0  && self.messageImage.frame.origin.x < 60{
                        UIView.animateWithDuration(0.8, delay: 0.0,
                            options: [], animations: { () -> Void in
                                print("change check to gray")
                                self.archiveView.backgroundColor = UIColor.grayColor()
                            }, completion: { (Bool) -> Void in
                        })
                    
                    }else if self.messageImage.frame.origin.x > 60 && self.messageImage.frame.origin.x < 260{
                        //turn green
                        UIView.animateWithDuration(0.8, delay: 0.0,
                            options: [], animations: { () -> Void in
                                print("change check to green")
                                self.messageImage.frame.origin.x = 260
                                self.archiveView.frame.origin.x = -60
                                self.archiveView.backgroundColor = UIColor.greenColor()
                            }, completion: { (Bool) -> Void in
                        })
                    }else if self.messageImage.frame.origin.x > 260 && self.messageImage.frame.origin.x < 320{
                        //turn red
                        UIView.animateWithDuration(0.8, delay: 0.0,
                            options: [], animations: { () -> Void in
                                print("change check to red")
                                self.messageImage.frame.origin.x = 300
                                self.archiveView.frame.origin.x = -20
                                self.archiveView.backgroundColor = UIColor.redColor()
                            }, completion: { (Bool) -> Void in
                        })
                    }
                    
                    
                    
                }
                
            //move left
            }else{
                //put away the archive side
//                if messageImage.frame.origin.x < 0{
//                    UIView.animateWithDuration(0.8, delay: 0.0,
//                        options: [], animations: { () -> Void in
//                            print("in the put right side away")
//                            self.messageImage.frame.origin.x = 0
//                            //self.archiveView.frame.origin.x = 320
//                            //self.rescheduleListView.backgroundColor = UIColor.grayColor()
//                            //self.archiveView.backgroundColor = UIColor.grayColor()
//
//                            
//                        }, completion: { (Bool) -> Void in
//                            
//                    })
//                }else{
                    //do left stuff
                
                if self.messageImage.frame.origin.x > -60{

                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                           print("am I in here")
                            self.rescheduleListView.backgroundColor = UIColor.grayColor()
                            self.messageImage.frame.origin.x = 0
                            

                        }, completion: { (Bool) -> Void in
                        print("something in here")
                            
                    })
                    
                    
                    
//                    UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
//                        
//                        self.messageImage.frame.origin.x = 0
//                        self.rescheduleListView.frame.origin.x = 360
//                        self.archiveView.frame.origin.x = -360
//                        }, completion: { (Bool) -> Void in
//                    })

                    
                }else if self.messageImage.frame.origin.x < -60 && self.messageImage.frame.origin.x > -260{

                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            
                            self.messageImage.frame.origin.x = -260
                            self.rescheduleListView.frame.origin.x = 60
                            
                            self.rescheduleListView.backgroundColor = UIColor.yellowColor()
                        }, completion: { (Bool) -> Void in

                    })
  
                }else if self.messageImage.frame.origin.x < -260{
   
                    UIView.animateWithDuration(0.8, delay: 0.0,
                        options: [], animations: { () -> Void in
                            
                            self.messageImage.frame.origin.x = -300
                            self.rescheduleListView.frame.origin.x = 20
                            
                            self.rescheduleListView.backgroundColor = UIColor.brownColor()
                            }, completion: { (Bool) -> Void in

                        })
                    }
    
                
                }

            }

//            if (self.messageImage.frame.origin.x > -60 && self.messageImage.frame.origin.x < 60){
//                
//                    UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options:[] , animations: { () -> Void in
//
//                            self.messageImage.frame.origin.x = 0
//                            self.rescheduleListView.frame.origin.x = 360
//                            self.archiveView.frame.origin.x = -360
//                                    }, completion: { (Bool) -> Void in
//                            })
//
//            }

        }

//    }


//}
