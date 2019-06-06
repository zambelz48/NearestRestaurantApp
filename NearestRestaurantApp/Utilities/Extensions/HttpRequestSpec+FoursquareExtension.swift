//
//  HttpRequestSpec+FoursquareExtension.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

extension HttpRequestSpec {
	
	mutating func constructFoursquareRequestSpec() {
		appendParameters(key: "client_id", value: Config.foursquareClientID)
		appendParameters(key: "client_secret", value: Config.foursquareSecretKey)
		appendParameters(key: "v", value: Config.foursquareApiVersion)
	}
	
}
