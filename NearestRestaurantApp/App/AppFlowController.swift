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
		
		homeViewController.onEvent = { [weak self] (event: HomeViewController.Event) in
			
			guard let self = self else {
				return
			}
			
			switch event {
				
			case .openVenueDetail(let venueId):
				let venueDetailViewController = self.createVenueDetailViewController(with: venueId)
				self.navigationController.pushViewController(venueDetailViewController, animated: true)
				
			}
			
		}
		
		return homeViewController
	}
	
	private func createVenueDetailViewController(with venueId: String) -> UIViewController {
		
		let venueDetailModel = VenueDetailDefaultModel(urlSession: URLSession.defaultConfig())
		let venueDetailViewModel = VenueDetailDefaultViewModel(venueId: venueId, venueDetailModel: venueDetailModel)
		let venueDetailViewController = VenueDetailViewController(viewModel: venueDetailViewModel)
		
		venueDetailViewController.onEvent = { (event: VenueDetailViewController.Event) in
			
			switch event {
				
			case .back:
				self.navigationController.popViewController(animated: true)
				
			}
			
		}
		
		return venueDetailViewController
	}
}
