//
//  VenueIcon.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

struct VenueIcon : Codable {
	
	let prefix: String
	let suffix: String
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		prefix = try container.decodeIfPresent(String.self, forKey: .prefix) ?? ""
		suffix = try container.decodeIfPresent(String.self, forKey: .suffix) ?? ""
		
	}
}
