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

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		let model = VenuesDefaultModel(urlSession: URLSession.defaultConfig())
		let viewModel = HomeDefaultViewModel(venuesModel: model)
		let rootViewController = HomeViewController(viewModel: viewModel)
		
		window = UIWindow()
		window?.rootViewController = UINavigationController(rootViewController: rootViewController)
		window?.makeKeyAndVisible()
		
		return true
	}

}
