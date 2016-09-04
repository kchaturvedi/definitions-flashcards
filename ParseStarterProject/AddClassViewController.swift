//
//  AddClassViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Evan Amstutz on 12/2/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import Foundation
import Parse
import UIKit

class AddClassViewController: UIViewController {

    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseID: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCourse(sender: AnyObject) {
		
        let name = courseName.text
        let id = courseID.text
		
        if id != "" && name != "" {
			
            let newCourse = PFObject(className:"Courses")
            newCourse["courseName"] = name
            newCourse["courseNumber"] = id
            newCourse["subjectId"] = subjectArr[chosenSubject].objectId!
            newCourse.saveInBackground()
        }
    }
}