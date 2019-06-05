//
//  VenueLocation.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

struct VenueLocation : Codable {
	
	let address: String
	let crossStreet: String
	let lat: Double
	let lng: Double
	let distance: Int
	let city: String
	let state: String
	let country: String
	let formattedAddress: [String]
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
		crossStreet = try container.decodeIfPresent(String.self, forKey: .crossStreet) ?? ""
		lat = try container.decodeIfPresent(Double.self, forKey: .lat) ?? 0.0
		lng = try container.decodeIfPresent(Double.self, forKey: .lng) ?? 0.0
		distance = try container.decodeIfPresent(Int.self, forKey: .distance) ?? 0
		city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
		state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
		country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
		formattedAddress = try container.decodeIfPresent([String].self, forKey: .formattedAddress) ?? [String]()
		
	}
	
}
