//
//  MockHttpResponse.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

final class MockHttpResponse {
	
	private init() {  }
	
	static func successfulURLSession() -> StubURLSession {
		return StubURLSession(statusCode: 200, fakeResponse: FakeJsonData.sampleJson)
	}
	
	static func successfulFoursquareURLSession() -> StubURLSession {
		return StubURLSession(statusCode: 200, fakeResponse: FakeJsonData.foursquareJson)
	}
	
	static func successfulFoursquareVenuesURLSession() -> StubURLSession {
		return StubURLSession(statusCode: 200, fakeResponse: FakeJsonData.foursquareVenuesJson)
	}
	
	static func failedURLSession() -> StubURLSession {
		return StubURLSession(statusCode: 400, fakeResponse: [])
	}
	
	static func failedFoursquareURLSession() -> StubURLSession {
		return StubURLSession(statusCode: 400, fakeResponse: FakeJsonData.foursquareErrorJson)
	}
	
}
