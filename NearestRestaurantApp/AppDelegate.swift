//
//  AppDelegate.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 04/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	
	private var appFlowController: AppFlowController?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		window = UIWindow()
		window?.rootViewController = rootViewController()
		window?.makeKeyAndVisible()
		
		return true
	}
	
	func rootViewController() -> UIViewController {
		
		let mainNavigationController = UINavigationController()
		appFlowController = AppFlowController(using: mainNavigationController)
		
		guard let navigationController = appFlowController?.navigationController else {
			return mainNavigationController
		}
		
		return navigationController
	}

}
