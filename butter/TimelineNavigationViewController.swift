//
//  TimelineNavigationViewController.swift
//  butter
//
//  Created by Will Dalton on 9/21/15.
//  Copyright © 2015 daltomania. All rights reserved.
//

import UIKit

class TimelineNavigationViewController: UINavigationController {

    var timelineType: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = viewControllers[0] as! TimelineController
        vc.timelineType = timelineType
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
