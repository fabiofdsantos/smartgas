//
//  facebookControllerViewController.swift
//  smartgas
//
//  Created by Fabio on 12/21/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit
import Social

class facebookControllerViewController: UIViewController {
    

    

    
    
        
    @IBOutlet weak var txtSocial: UITextField!

    @IBAction func shareAction(sender: UIBarButtonItem) {
    
        let actionSheet = UIAlertController(title: "", message: "Share your location", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
    
    
        let tweetAction = UIAlertAction(title: "Share on Twiter", style: UIAlertActionStyle.Default) { (action) -> Void in
            
    
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterVC.setInitialText("Preco do combustivel na Reposol  \(self.txtSocial.text)")
                self.presentViewController(twitterVC, animated: true, completion: nil)
            } else {
                self.showAlert("You must first log on to your Twitter account.")
            }
            
        }
    
        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookVC.setInitialText("Preco do combustivel na Reposol  \(self.txtSocial.text)")
                self.presentViewController(facebookVC, animated: true, completion: nil)
                
            }else{
                self.showAlert("You  must first log on to your Facebook account.")
            }
        }
    
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) { (action) -> Void in
        
        }
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(dismissAction)
    
        presentViewController(actionSheet, animated: true, completion: nil)
    
        
    }
    
    
    func showAlert (message:String)->Void{
        let alertController = UIAlertController(title: "Sharing error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
