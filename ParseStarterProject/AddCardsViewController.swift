//
//  AddCardsViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Evan Amstutz on 12/2/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class AddCardsViewController: UIViewController {
	
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var answerLabel: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitCard(sender: AnyObject) {
        
        let question = questionLabel.text
        let answer = answerLabel.text
		
        if question != "" && answer != "" {
			
			let newAns = PFObject(className: "Answers")
			newAns["answer"] = answer
			newAns["courseId"] = courseArr[chosenCourse].objectId!
			do {
				try newAns.save()
			} catch {}
			
			let query = PFQuery(className: "Answers")
			query.whereKey("courseId", equalTo: courseArr[chosenCourse].objectId!)
			query.addDescendingOrder("updatedAt")
			query.limit = 1
			query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
				
				if error == nil {
					if let objects = objects as [PFObject]! {
						for object in objects {
							let newQuestion = PFObject(className: "Questions")
							newQuestion["question"] = question
							newQuestion["courseId"] = courseArr[chosenCourse].objectId!
							newQuestion["answerId"] = object.objectId
							newQuestion.saveInBackground()
						}
					}
				}
			})
        }
		
		questionLabel.text = ""
		answerLabel.text = ""
    }
}
