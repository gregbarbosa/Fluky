//
//  TTAbout.swift
//  Fluky
//
//  Created by Greg Barbosa on 9/16/14.
//  Copyright (c) 2014 Tiny Tugboats. All rights reserved.
//

import UIKit

class TTAbout: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 2
        case 1:
            return 3
        case 2:
            return 1
        default:
            return 1
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0 && indexPath.section == 0) {
            println("@randomapi tapped")
            UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=randomapi"))
        }
        if(indexPath.row == 1 && indexPath.section == 0) {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.randomuser.me"))
        }
        if(indexPath.row == 0 && indexPath.section == 1) {
            UIApplication.sharedApplication().openURL(NSURL(string: "twitter://user?screen_name=tinytugboats"))
        }
        if(indexPath.row == 1 && indexPath.section == 1) {
            UIApplication.sharedApplication().openURL(NSURL(string: "http://tinytugboats.com"))
        }
        if(indexPath.row == 2 && indexPath.section == 1) {
            UIApplication.sharedApplication().openURL(NSURL(string: "gregbarbosa@me.com"))
        }
        else if(indexPath.row == 0 && indexPath.section == 2) {
            println("Rate Me tapped")
        }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
