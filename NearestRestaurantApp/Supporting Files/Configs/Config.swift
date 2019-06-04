//
//  Config.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 04/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

fileprivate enum ConfigKeys: String {
	case appName = "APP_NAME"
	case appBundleID = "APP_BUNDLE_ID"
	case appVersion = "APP_VERSION"
	case baseApiURL = "BASE_API_URL"
	case foursquareClientID = "FOURSQUARE_CLIENT_ID"
	case foursquareSecretKey = "FOURSQUARE_SECRET_KEY"
}

fileprivate final class PlistUtils {
	
	private init() {}
	
	static func getValue(from key: ConfigKeys) -> String {
		
		guard let info = Bundle.main.infoDictionary else {
			fatalError("Plist file not found")
		}
		
		guard let value = info[key.rawValue] as? String else {
			fatalError("\(key)'s not set in plist file")
		}
		
		return value
	}
	
}

internal enum Config {
	
	static let appName = PlistUtils.getValue(from: ConfigKeys.appName)
	static let appVersion = PlistUtils.getValue(from: ConfigKeys.appVersion)
	static let appBundleID = PlistUtils.getValue(from: ConfigKeys.appBundleID)
	static let baseApiURL = PlistUtils.getValue(from: ConfigKeys.baseApiURL)
	static let foursquareClientID = PlistUtils.getValue(from: ConfigKeys.foursquareClientID)
	static let foursquareSecretKey = PlistUtils.getValue(from: ConfigKeys.foursquareSecretKey)
	static let foursquareApiVersion: String = {
		let date = Date()
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyyMMdd"
		
		return formatter.string(from: date)
	}()
	
}
