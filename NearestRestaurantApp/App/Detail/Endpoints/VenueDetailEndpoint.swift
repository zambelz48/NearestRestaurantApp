//
//  VenueDetailEndpoint.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

enum VenueDetailEndpoint {
	
	case getDetail(venueId: String)
	
	var rawValue: String {
		
		let apiURL = Config.baseApiURL
		
		switch self {
			
		case .getDetail(let venueId):
			return apiURL + "/venues/\(venueId)"
			
		}
		
	}
	
}
