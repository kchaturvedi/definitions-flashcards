//
//  TestYourselfTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kartik Chaturvedi on 17/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LeaderboardViewController: PFQueryTableViewController {
	
	override init(style: UITableViewStyle, className: String?) {
		super.init(style: style, className: className)
		parseClassName = "User"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		parseClassName = "User"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	override func queryForTable() -> PFQuery {
		let query = PFUser.query()!
		query.addDescendingOrder("score")
		return query
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
		let cellIdentifier = "cell"
		
		var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
		if cell == nil {
			cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
		}
		
		if let object = object {
			cell!.textLabel?.text = object["username"] as? String
			if let score = object["score"] as? Int {
				cell!.detailTextLabel!.text = String(score)
			}
		}
		
		return cell
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}