//
//  HttpHandlerTests.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift

struct SampleJSON : Codable {
	
	let sampleKeyOne: String
	let sampleKeyTwo: String
	
}

struct DesiredData : Codable {
	
	let keyOne: String
	let keyTwo: String
	
}

struct SampleFoursquareJSON : Codable {
	
	let desiredData: DesiredData
	
}

class HttpHandlerTests: XCTestCase {

	private var disposeBag: DisposeBag!
	private var httpRequestSpec: HttpRequestSpec!
	
    override func setUp() {
		super.setUp()
		
		disposeBag = DisposeBag()
		httpRequestSpec = HttpRequestSpec(url: "http://test.com")
    }

    override func tearDown() {
		
		httpRequestSpec = nil
		
		disposeBag = nil
		
		super.tearDown()
    }
	
	func testBasicRequest() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and success")
		
		let httpHandler = HttpHandler.sharedInstance(session: MockHttpResponse.successfulURLSession())
		httpHandler.request(spec: httpRequestSpec, onSuccess: { (data: Data?) in
			
			guard let validData = data else {
				XCTFail("data is nil")
				return
			}
			
			XCTAssert(!validData.isEmpty)
			
			requestExpectation.fulfill()
		})
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}
	
	func testBasicJsonRequest() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and success")
		
		let httpHandler = HttpHandler.sharedInstance(session: MockHttpResponse.successfulURLSession())
		httpHandler.jsonRequest(spec: httpRequestSpec, onSuccess: { (response: [SampleJSON]?) in
			
			guard let validResponse = response else {
				XCTFail("Invalid response")
				return
			}
			
			XCTAssert(validResponse.count == FakeJsonData.sampleJson.count)
			
			requestExpectation.fulfill()
		})
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}
	
	func testSuccessfulRequestWithFoursquareJsonFormat() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and success")
		
		let httpHandler = HttpHandler.sharedInstance(session: MockHttpResponse.successfulFoursquareURLSession())
		let observable: Observable<SampleFoursquareJSON> = httpHandler.foursquareRequestObservable(spec: httpRequestSpec)
		
		observable
			.subscribe(
				onNext: { (response: SampleFoursquareJSON) in
					
					let data = response.desiredData
					
					XCTAssert(
						data.keyOne == "Value of key one" &&
						data.keyTwo == "Value of key two"
					)
					requestExpectation.fulfill()
				},
				onError: { (error: Error) in
					XCTFail(error.localizedDescription)
					requestExpectation.fulfill()
				}
			)
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}
	
	func testFailedRequestWithFoursquareJsonFormat() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and failed")
		
		let httpHandler = HttpHandler.sharedInstance(session: MockHttpResponse.failedFoursquareURLSession())
		let observable: Observable<SampleFoursquareJSON> = httpHandler.foursquareRequestObservable(spec: httpRequestSpec)
		
		observable
			.subscribe(onError: { (error: Error) in
				XCTAssert(error.localizedDescription == "Foursquare error detail")
				requestExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}

}
