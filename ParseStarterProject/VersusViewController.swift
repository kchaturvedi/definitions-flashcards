//
//  SelfTestCardsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kartik Chaturvedi on 24/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class VersusViewController: UIViewController {
	
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet weak var button3: UIButton!
	@IBOutlet weak var button4: UIButton!
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	
	var library2 = [String: String]()
	var randAnswers = [String]()
	var curQues = String()
	var curAns = String()
	var timer = NSTimer()
	var score = 0
	
	var quesArray = [PFObject]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		updateLibrary()
	}
	
	override func viewDidAppear(animated: Bool) {
		updateQuestion()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		updateLibrary()
		for var i = 1; i <= 4; i++ {
			let button = self.view.viewWithTag(i) as! UIButton
			button.hidden = false
		}
	}
	
	@IBAction func answerChosen(sender: UIButton) {
		
		timer.invalidate()
		if sender.titleLabel?.text == curAns {
			sender.tintColor = UIColor(red: 0, green: 255, blue: 0, alpha: 1)
			score += Int(timerLabel.text!)!
		} else {
			sender.tintColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1)
		}
		
		scoreLabel.text = String(score)
		updateQuestion()
	}
	
	func updateQuestion() {
		
		if library2.count != 0 {
			
			timerLabel.text = "15"
			timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
			
			(curQues, curAns) = library2.first!
			questionLabel.text = curQues
			
			let correctButton = Int(arc4random_uniform(4)) + 1
			
			for var i = 1; i <= 4; i++ {
				if i == correctButton {
					let button = self.view.viewWithTag(i) as! UIButton
					button.setTitle(curAns, forState: .Normal)
					button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
				} else {
					let button = self.view.viewWithTag(i) as! UIButton
					button.setTitle(randAnswers[Int(arc4random_uniform(UInt32(randAnswers.count)))], forState: .Normal)
					button.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
				}
			}
			
			library2.removeValueForKey(questionLabel.text!)
			
		} else {
			questionLabel.text = "All done!"
			timer.invalidate()
			let userScore = PFUser.currentUser()!["score"] as! Int
			PFUser.currentUser()!["score"] = score + userScore
			PFUser.currentUser()?.saveInBackground()
			for var i = 1; i <= 4; i++ {
				let button = self.view.viewWithTag(i) as! UIButton
				button.hidden = true
			}
			
			timer = NSTimer()
			performSegueWithIdentifier("leaderboard", sender: self)
		}
	}
	
	func updateLibrary() {
		
		let quesQuery = PFQuery(className: "Questions")
		quesQuery.whereKey("courseId", equalTo: courseArr[chosenCourse].objectId!)
		var objects = [PFObject]()
		do {
			objects = try quesQuery.findObjects()
		} catch {}
		
		if let objects = objects as [PFObject]! {
			for object in objects {
				
				let ansQuery = PFQuery(className: "Answers")
				ansQuery.whereKey("courseId", equalTo: courseArr[chosenCourse].objectId!)
				var ansObjects = [PFObject]()
				do {
					ansObjects = try ansQuery.findObjects()
				} catch {}
				
				if let ansObjects = ansObjects as [PFObject]! {
					for ansObject in ansObjects {
						if ansObject.objectId! == object["answerId"] as! String {
							self.library2[object["question"] as! String] = ansObject["answer"] as? String
						} else {
							self.randAnswers.append(ansObject["answer"] as! String)
						}
					}
				}
			}
		}
		

	}
	
	func updateTimer() {
		
		var time = Int(timerLabel.text!)!
		if time <= 0 {
			timer.invalidate()
			updateQuestion()
		} else {
			time = time - 1
			timerLabel.text = String(time)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}