//
//  MenuController.swift
//  butter
//
//  Created by Will Dalton on 9/21/15.
//  Copyright © 2015 daltomania. All rights reserved.
//

import UIKit

class MenuController: UIViewController, UITableViewDataSource,
UITableViewDelegate {

    var viewControllers: [UIViewController] = []
    var 🍔ViewController: 🍔Controller!
    private var profileNavigationController: UIViewController!
    private var timelineNavigationController: UIViewController!
    let titles = ["Timeline", "Profile"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewControllerWithIdentifier("profileNavigationController")
        timelineNavigationController = storyboard.instantiateViewControllerWithIdentifier("timelineNavigationController")
        
        viewControllers.append(timelineNavigationController)
        viewControllers.append(profileNavigationController)
        
        🍔ViewController.contentViewController = timelineNavigationController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        🍔ViewController.contentViewController = viewControllers[indexPath.row]
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
