//
//  HomeScreenViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Kartik Chaturvedi on 1/12/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var selectedMode = 0

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
    }
	
	@IBAction func unwindToHome(segue: UIStoryboardSegue) {
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}
