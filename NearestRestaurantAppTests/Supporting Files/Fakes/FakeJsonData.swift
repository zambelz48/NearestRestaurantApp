//
//  FakeJsonData.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

final class FakeJsonData {
	
	static let sampleJson: [[String: Any]] = [
		[
			"sampleKeyOne": "Sample value from key 1.1",
			"sampleKeyTwo": "Sample from key 1.2"
		],
		[
			"sampleKeyOne": "Sample value from key 2.1",
			"sampleKeyTwo": "Sample from key 2.2"
		]
	]
	
	static let foursquareJson: [String: Any] = [
		"meta": [
			"code": 200,
			"requestId": "req-123"
		],
		"response": [
			"desiredData": [
				"keyOne": "Value of key one",
				"keyTwo": "Value of key two"
			]
		]
	]
	
	static let foursquareErrorJson: [String: Any] = [
		"meta": [
			"code": 400,
			"errorType": "foursquare_error_type",
			"errorDetail": "Foursquare error detail",
			"requestId": "req-456"
		],
		"response": []
	]
	
	private init() { }
}
