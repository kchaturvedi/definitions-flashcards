//
//  CoursesTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kartik Chaturvedi on 17/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

var courseArr = [PFObject]()
var chosenCourse = Int()

class CoursesTableViewController: PFQueryTableViewController {
	
	override init(style: UITableViewStyle, className: String?) {
		super.init(style: style, className: className)
		parseClassName = "Courses"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		parseClassName = "Courses"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	override func queryForTable() -> PFQuery {
		let query = PFQuery(className: self.parseClassName!)
		query.whereKey("subjectId", equalTo: subjectArr[chosenSubject].objectId!)
		
		courseArr.removeAll()
		
		return query
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
		let cellIdentifier = "cell"
		
		var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
		if cell == nil {
			cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
		}
		
		if let object = object {
			cell!.textLabel?.text = object["courseName"] as? String
			cell!.detailTextLabel!.text = object["courseNumber"] as? String
			courseArr.append(object)
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
		
		chosenCourse = indexPath.row
		return indexPath
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "addCourse" {
            segue.destinationViewController.title = courseArr[chosenCourse]["courseName"] as? String
			library.removeAll()
        }
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(animated: Bool) {
		self.loadObjects()
		self.queryForTable()
		self.tableView.reloadData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func unwindCreatedCourse(segue: UIStoryboardSegue) {
	}
	
}