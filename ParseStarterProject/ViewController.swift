/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit

class ViewController: UIViewController, PFLogInViewControllerDelegate {

	let logInController = MyLogInViewController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewDidAppear(animated: Bool) {
		if ((PFUser.currentUser()?.username == nil)) {
			logInController.signUpController = MySignUpViewController()
			logInController.delegate = self
			logInController.fields = [.UsernameAndPassword, .LogInButton, .SignUpButton, .PasswordForgotten, .DismissButton]
			self.presentViewController(logInController, animated:true, completion: nil)
		} else {
			self.performSegueWithIdentifier("loggedIn", sender: self)
		}
	}
	
	func logInViewController(controller: PFLogInViewController, didLogInUser user: PFUser) -> Void {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func unwindLogout(segue: UIStoryboardSegue) {
		
		PFUser.logOut()
		
	}
}

class MyLogInViewController: PFLogInViewController, PFSignUpViewControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		signUpController?.delegate = self
		let logoView = UIImageView(image: UIImage(named:"coolOhm.png"))
		logoView.contentMode = UIViewContentMode.ScaleAspectFit
		self.logInView!.logo = logoView
	}
	
	func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) -> Void {
		user["score"] = 0
		user.saveInBackground()
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}

class MySignUpViewController: PFSignUpViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let logoView = UIImageView(image: UIImage(named:"coolOhm.png"))
		logoView.contentMode = UIViewContentMode.ScaleAspectFit
		self.signUpView!.logo = logoView
	}
}