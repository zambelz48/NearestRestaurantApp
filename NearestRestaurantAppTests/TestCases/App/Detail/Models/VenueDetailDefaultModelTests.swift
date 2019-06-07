//
//  VenueDetailDefaultModelTests.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift

class VenueDetailDefaultModelTests: XCTestCase {

	private var disposeBag: DisposeBag!
	
    override func setUp() {
		super.setUp()
		
		disposeBag = DisposeBag()
    }

    override func tearDown() {
		
		disposeBag = nil
		
		super.tearDown()
    }
	
	func testSuccessfulGetVenueDetail() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and success")
		
		let model = VenueDetailDefaultModel(urlSession: MockHttpResponse.successfulFoursquareVenueDetailURLSession())
		
		model.getDetail(by: "venue-123")
			.subscribe(onNext: { (venue: VenueDetail) in
				XCTAssert(venue.id == "5291d1d6498e70f865cb23e3")
				requestExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}
	
	func testFailedGetVenueDetail() {
		
		let requestExpectation = expectation(description: "Expected the request getting called and failed")
		
		let model = VenueDetailDefaultModel(urlSession: MockHttpResponse.failedFoursquareURLSession())
		
		model.getDetail(by: "venue-123")
			.subscribe(onError: { (error: Error) in
				XCTAssert(error.localizedDescription == "Foursquare error detail")
				requestExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [ requestExpectation ], timeout: 1.0)
	}

}
