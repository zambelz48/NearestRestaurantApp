//
//  VenueDetail.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

struct VenueDetail : Codable {
	
	private(set) var id: String
	private(set) var name: String
	private(set) var location: VenueLocation?
	private(set) var categories: [VenueCategory]?
	private(set) var referralId: String
	private(set) var hasPerk: Bool
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
		name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
		location = try container.decodeIfPresent(VenueLocation.self, forKey: .location)
		categories = try container.decodeIfPresent([VenueCategory].self, forKey: .categories)
		referralId = try container.decodeIfPresent(String.self, forKey: .referralId) ?? ""
		hasPerk = try container.decodeIfPresent(Bool.self, forKey: .hasPerk) ?? false
	}
	
}
