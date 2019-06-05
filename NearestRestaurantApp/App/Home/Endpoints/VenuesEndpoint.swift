//
//  VenuesEndpoint.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

enum VenuesEndpoint {
	
	case fetch
	
	var rawValue: String {
		
		let apiURL = Config.baseApiURL
		
		switch self {
			
		case .fetch:
			return apiURL + "/venues/search"
			
		}
		
	}
	
}
