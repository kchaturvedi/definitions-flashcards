//
//  AppDelegate.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit

import Bolts
import Parse

// If you want to use any of the UI components, uncomment this line
// import ParseUI

// If you want to use Crash Reporting - uncomment this line
// import ParseCrashReporting

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	//--------------------------------------
	// MARK: - UIApplicationDelegate
	//--------------------------------------
	
	func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		// Enable storing and querying data from Local Datastore.
		// Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
		Parse.enableLocalDatastore()
		
		Parse.setApplicationId("Wpv48lZ7j56KrG1lBIlaQfeduTekqFsuolO4ITLP",
			clientKey: "ppvhCrUxVCPB1IEIs8yRz0GsYvEyRaHMoZWUJBW7")
		
		PFUser.enableAutomaticUser()
		
		let defaultACL = PFACL();
		
		// If you would like all objects to be private by default, remove this line.
		defaultACL.setPublicReadAccess(true)
		
		PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser:true)
		
		return true
	}
	
}
