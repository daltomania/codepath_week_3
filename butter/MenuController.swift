//
//  MenuController.swift
//  butter
//
//  Created by Will Dalton on 9/21/15.
//  Copyright © 2015 daltomania. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    var viewControllers: [UIViewController] = []
    private var profileNavigationController: UIViewController!
    private var timelineNavigationController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("profileNavigationController")
        timelineNavigationController = storyboard.instantiateViewControllerWithIdentifier("timelineNavigationController")
        
        viewControllers.append(profileNavigationController)
        viewControllers.append(timelineNavigationController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
