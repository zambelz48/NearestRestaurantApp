//
//  FoursquareResponse.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

struct FoursquareMeta : Codable {
	
	let code: Int
	let requestId: String
	
	init(from decoder: Decoder) throws {
		
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		code = try container.decodeIfPresent(Int.self, forKey: .code) ?? 400
		requestId = try container.decodeIfPresent(String.self, forKey: .requestId) ?? ""
		
	}
}

struct FoursquareResponse<T> : Codable where T : Codable {
	
	let meta: FoursquareMeta?
	let response: T?
	
	init(from decoder: Decoder) throws {
	
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		meta = try container.decodeIfPresent(FoursquareMeta.self, forKey: .meta) ?? nil
		response = try container.decodeIfPresent(T.self, forKey: .response) ?? nil
		
	}
}
