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

var subjectArr = [PFObject]()
var chosenSubject = Int()

class TestYourselfTableViewController: PFQueryTableViewController {
	
	override init(style: UITableViewStyle, className: String?) {
		super.init(style: style, className: className)
		parseClassName = "Subjects"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		parseClassName = "Subjects"
		pullToRefreshEnabled = true
		paginationEnabled = true
		objectsPerPage = 25
	}
	
	override func queryForTable() -> PFQuery {
		let query = PFQuery(className: self.parseClassName!)
		
		return query
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
		let cellIdentifier = "cell"
		
		var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PFTableViewCell
		if cell == nil {
			cell = PFTableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
		}
		
		if let object = object {
			cell!.textLabel?.text = object["subjectName"] as? String
			subjectArr.append(object)
		}
		
		return cell
	}
	
	override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
		
		chosenSubject = indexPath.row
		
		return indexPath
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
        // Dispose of any resources that can be recreated.
    }

}