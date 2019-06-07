//
//  VenuesDefaultModelTests.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift

class VenuesDefaultModelTests: XCTestCase {

	private var disposeBag: DisposeBag!
	
    override func setUp() {
		super.setUp()
		
		disposeBag = DisposeBag()
    }

    override func tearDown() {
		
		disposeBag = nil
		
		super.tearDown()
    }
	
	func testSuccessfulGetVenues() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and success")
		
		let model = VenuesDefaultModel(urlSession: MockHttpResponse.successfulFoursquareVenuesURLSession())
		let request = VenuesRequest(latitude: 0.0, longitude: 0.0, radius: 0.0)
		
		model.fetch(with: request)
			.subscribe(onNext: { (venues: [VenueDetail]) in
				
				XCTAssert(venues.count > 0)
				
				requestExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}
	
	func testFailedGetVenues() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and failed")
		
		let model = VenuesDefaultModel(urlSession: MockHttpResponse.failedFoursquareURLSession())
		let request = VenuesRequest(latitude: 0.0, longitude: 0.0, radius: 0.0)
		
		model.fetch(with: request)
			.subscribe(onError: { (error: Error) in
				XCTAssert(error.localizedDescription == "Foursquare error detail")
				requestExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}

}
