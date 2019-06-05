//
//  VenueCategory.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

struct VenueCategory : Codable {
	
	let id: String
	let name: String
	let pluralName: String
	let shortName: String
	let icon: VenueIcon?
	let primary: Bool
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
		name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
		pluralName = try container.decodeIfPresent(String.self, forKey: .pluralName) ?? ""
		shortName = try container.decodeIfPresent(String.self, forKey: .shortName) ?? ""
		icon = try container.decodeIfPresent(VenueIcon.self.self, forKey: .icon)
		primary = try container.decodeIfPresent(Bool.self, forKey: .primary) ?? false
		
	}
}
