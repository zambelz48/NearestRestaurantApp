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
	
	static let foursquareVenuesJson: [String: Any] = [
		"meta": [
			"code": 200,
			"requestId": "5cf6981b1ed21914bbe106ed"
		],
		"response": [
			"venues": [
				[
					"id": "5291d1d6498e70f865cb23e3",
					"name": "Foodcourt BMI",
					"location": [
						"address": "Komp. Bumi Manjahlega Indah",
						"crossStreet": "Margahayu, Metro",
						"lat": -6.95408,
						"lng": 107.67058,
						"labeledLatLngs": [
							[
								"label": "display",
								"lat": -6.95408,
								"lng": 107.67058
							]
						],
						"distance": 521,
						"cc": "ID",
						"city": "Bandung",
						"state": "Jawa Barat",
						"country": "Indonesia",
						"formattedAddress": [
							"Komp. Bumi Manjahlega Indah (Margahayu, Metro)",
							"Bandung",
							"Jawa Barat",
							"Indonesia"
						]
					],
					"categories": [
						[
							"id": "4f2a210c4b9023bd5841ed28",
							"name": "Housing Development",
							"pluralName": "Housing Developments",
							"shortName": "Housing Development",
							"icon": [
								"prefix": "https://ss3.4sqi.net/img/categories_v2/building/housingdevelopment_",
								"suffix": ".png"
							],
							"primary": true
						]
					],
					"referralId": "v-1559664667",
					"hasPerk": false
				]
			]
		]
	]
	
	static let foursquareVenueDetailJson: [String: Any] = [
		"meta": [
			"code": 200,
			"requestId": "5cf6981b1ed21914bbe106ed"
		],
		"response": [
			"venue": [
				"id": "5291d1d6498e70f865cb23e3",
				"name": "Foodcourt BMI",
				"location": [
					"address": "Komp. Bumi Manjahlega Indah",
					"crossStreet": "Margahayu, Metro",
					"lat": -6.95408,
					"lng": 107.67058,
					"labeledLatLngs": [
						[
							"label": "display",
							"lat": -6.95408,
							"lng": 107.67058
						]
					],
					"distance": 521,
					"cc": "ID",
					"city": "Bandung",
					"state": "Jawa Barat",
					"country": "Indonesia",
					"formattedAddress": [
						"Komp. Bumi Manjahlega Indah (Margahayu, Metro)",
						"Bandung",
						"Jawa Barat",
						"Indonesia"
					]
				],
				"categories": [
					[
						"id": "4f2a210c4b9023bd5841ed28",
						"name": "Housing Development",
						"pluralName": "Housing Developments",
						"shortName": "Housing Development",
						"icon": [
							"prefix": "https://ss3.4sqi.net/img/categories_v2/building/housingdevelopment_",
							"suffix": ".png"
						],
						"primary": true
					]
				],
				"referralId": "v-1559664667",
				"hasPerk": false
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
