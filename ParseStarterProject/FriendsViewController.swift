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

class FriendsViewController: UITableViewController {
	
	var friends = [PFUser]()
	
	var refresher: UIRefreshControl!
	
	func refresh() {
		
		let query = PFUser.query()
		
		query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
			
			if let users = objects {
				
				self.friends.removeAll(keepCapacity: true)
				
				for object in users {
					
					if let user = object as? PFUser {
						
						if user.objectId != PFUser.currentUser()?.objectId {
							
							let query = PFQuery(className: "Friendships")
							query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
							query.whereKey("following", equalTo: user.objectId!)
							
							query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
								
								if let objects = objects {
									
									if objects.count > 0 {
										self.friends.append(user)
									}
								}
								
								self.tableView.reloadData()
							})
						}
					}
				}
			}
		})
		
		self.refresher.endRefreshing()
		
	}
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return friends.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
		
		cell.textLabel?.text = friends[indexPath.row].username
		cell.detailTextLabel!.text = String(friends[indexPath.row]["score"])
		
		return cell
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		refresher = UIRefreshControl()
		refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
		refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
		tableView.addSubview(refresher)
	}
	
	override func viewWillAppear(animated: Bool) {
		refresh()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}