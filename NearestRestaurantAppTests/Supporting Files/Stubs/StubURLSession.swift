//
//  StubURLSession.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

final class StubURLSession : URLSessionStandard {
	
	private var statusCode: Int
	private var fakeResponse: Any
	
	init(statusCode: Int, fakeResponse: Any) {
		self.statusCode = statusCode
		self.fakeResponse = fakeResponse
	}
	
	func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		
		var fakeData: Data? = nil
		do {
			fakeData = try JSONSerialization.data(withJSONObject: fakeResponse, options: .prettyPrinted)
		} catch {
			fakeData = nil
		}
		
		var error: Error?
		if (fakeData == nil) {
			error = ErrorFactory.unknown.detail
		}
		
		let fakeURLResponse = HTTPURLResponse(
			url: URL(string: "http://test.com")!,
			statusCode: statusCode,
			httpVersion: nil,
			headerFields: nil
		)
		
		let mockResponse: (data: Data?, urlResponse: URLResponse?, error: Error?) = (
			data: fakeData,
			urlResponse: fakeURLResponse,
			error: error
		)
		
		return StubSessionDataTask(response: mockResponse, completionHandler: completionHandler)
	}
	
}
