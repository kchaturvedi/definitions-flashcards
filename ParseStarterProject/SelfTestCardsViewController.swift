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

var library = [String: String]()

class SelfTestCardsViewController: UIViewController {

	@IBOutlet weak var card1: UIView!
	@IBOutlet weak var card2: UIView!
	@IBOutlet weak var titleItem: UINavigationItem!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		updateLibrary()
		
		let tap1Gesture = UITapGestureRecognizer(target: self, action: Selector("card1Tapped:"))
		let tap2Gesture = UITapGestureRecognizer(target: self, action: Selector("card2Tapped:"))
		card1.addGestureRecognizer(tap1Gesture)
		card2.addGestureRecognizer(tap2Gesture)
		
		let card1gesture = UIPanGestureRecognizer(target: self, action: Selector("card1Dragged:"))
		let card2gesture = UIPanGestureRecognizer(target: self, action: Selector("card2Dragged:"))
		card1.addGestureRecognizer(card1gesture)
		card2.addGestureRecognizer(card2gesture)
		
		card1.userInteractionEnabled = true
		card2.userInteractionEnabled = true
		
    }
	
	override func viewDidAppear(animated: Bool) {
		updateCard(card2)
	}
	
	func updateLibrary() {
		
		let quesQuery = PFQuery(className: "Questions")
		quesQuery.whereKey("courseId", equalTo: courseArr[chosenCourse].objectId!)
		quesQuery.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
			
			if error == nil {
				if let objects = objects as [PFObject]! {
					for object in objects {
						
						let ansQuery = PFQuery(className: "Answers")
						ansQuery.whereKey("courseId", equalTo: courseArr[chosenCourse].objectId!)
						ansQuery.getObjectInBackgroundWithId(object["answerId"] as! String, block: { (ansObject: PFObject?, error: NSError?) -> Void in
							
							if error == nil {
								
								library[object["question"] as! String] = ansObject!["answer"] as? String
								
							}
						})
					}
				}
			} else {
				print(error)
			}
		}
	}
	
	func card1Tapped(gesture: UITapGestureRecognizer) {
		
		let card = gesture.view!
		
		if gesture.state == UIGestureRecognizerState.Ended {
			
			showCardAnswer(card)
		}
	}
	
	func card2Tapped(gesture: UITapGestureRecognizer) {
		
		let card = gesture.view!
		
		if gesture.state == UIGestureRecognizerState.Ended {
			
			showCardAnswer(card)
		}
	}
	
	func card1Dragged(gesture: UIPanGestureRecognizer) {
		
		let translation = gesture.translationInView(self.view)
		let card = gesture.view!
		
		card.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
		
		let xFromCenter = card.center.x - self.view.bounds.width / 2
		var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
		let scale = min(100 / abs(xFromCenter), 1)
		var stretch = CGAffineTransformScale(rotation, scale, scale)
		
		card.transform = stretch
		
		if gesture.state == UIGestureRecognizerState.Began {
			updateCard(card2)
		}
		
		if gesture.state == UIGestureRecognizerState.Ended {
			
			rotation = CGAffineTransformMakeRotation(0)
			stretch = CGAffineTransformScale(rotation, 1, 1)
			card.transform = stretch
			card.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
			self.view.sendSubviewToBack(card)
		}
	}
	
	func card2Dragged(gesture: UIPanGestureRecognizer) {
		
		let translation = gesture.translationInView(self.view)
		let card = gesture.view!
		
		card.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
		
		let xFromCenter = card.center.x - self.view.bounds.width / 2
		var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
		let scale = min(100 / abs(xFromCenter), 1)
		var stretch = CGAffineTransformScale(rotation, scale, scale)
		
		card.transform = stretch
		
		if gesture.state == UIGestureRecognizerState.Began {
				updateCard(card1)
		}
		
		if gesture.state == UIGestureRecognizerState.Ended {
			
			rotation = CGAffineTransformMakeRotation(0)
			stretch = CGAffineTransformScale(rotation, 1, 1)
			card.transform = stretch
			card.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
			self.view.sendSubviewToBack(card)
		}
	}
	
	func showCardAnswer(card: UIView) {
		
		let answer: UILabel = card.viewWithTag(2) as! UILabel
		
		answer.hidden = false
		
	}
	
	func updateCard(card: UIView) {
		
		let questionCard: UILabel = card.viewWithTag(1) as! UILabel
		let answerCard: UILabel = card.viewWithTag(2) as! UILabel
		
		if library.isEmpty {
			
			library["All done!\n\nSwipe to start over!"] = "Swipe to start over!"
			updateLibrary()
		}
		
		(questionCard.text!, answerCard.text!) = library.first!
		answerCard.hidden = true
		library.removeValueForKey(questionCard.text!)
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}