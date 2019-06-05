//
//  AppFlowController.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

final class AppFlowController {
	
	private(set) var navigationController: UINavigationController
	
	init(using navigationController: UINavigationController) {
		
		self.navigationController = navigationController
		
		configureRootViewController()
	}
	
	private func configureRootViewController() {
		
		let rootViewController = createHomeViewController()
		
		navigationController.setViewControllers([ rootViewController ], animated: true)
	}
	
	private func createHomeViewController() -> UIViewController {
		
		let venuesModel = VenuesDefaultModel(urlSession: URLSession.defaultConfig())
		let homeViewModel = HomeDefaultViewModel(venuesModel: venuesModel)
		let homeViewController = HomeViewController(viewModel: homeViewModel)
		
		return homeViewController
	}
}
