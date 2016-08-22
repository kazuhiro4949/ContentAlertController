//
//  RegularAlertTableViewController.swift
//  CustomAlertControllerTest
//
//  Created by Kazuhiro Hayashi on 7/11/16.
//  Copyright © 2016 Kazuhiro Hayashi. All rights reserved.
//

import UIKit

class RegularAlertTableViewController: UITableViewController {

    var actions = [AlertAction]() {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var cellHeight = CGFloat(44)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: .ExtraLight))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let action = actions[indexPath.row]
        cell.textLabel?.text = action.title
        cell.textLabel?.textColor = action.configuration.textColor
        cell.backgroundColor = action.configuration.backgroundColor
        cell.textLabel?.font = action.configuration.font
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let action = actions[indexPath.row]
        dismissViewControllerAnimated(true) {
            action.handler?(action)
        }
        return indexPath
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.scrollEnabled = tableView.contentSize.height > tableView.frame.height
    }

    override var preferredContentSize: CGSize {
        set {}
        get { return tableView.contentSize }
    }
}
