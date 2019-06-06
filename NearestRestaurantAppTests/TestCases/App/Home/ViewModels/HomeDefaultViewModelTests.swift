//
//  HomeDefaultViewModelTests.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift

class HomeDefaultViewModelTests: XCTestCase {

	private var disposeBag: DisposeBag!
	private var viewModel: HomeViewModel!
	
    override func setUp() {
		super.setUp()
		
		disposeBag = DisposeBag()
    }

    override func tearDown() {
		
		viewModel = nil
		
		disposeBag = nil
		
		super.tearDown()
    }

	func testLoadVenuesSuccess() {
		
		let loadExpectation = expectation(description: "Expected 'onNext' event called")
		
		let mockVenuesModel = MockVenuesModel(isSuccess: true)
		viewModel = HomeDefaultViewModel(venuesModel: mockVenuesModel)
		
		viewModel.loadVenuesSuccess
			.subscribe(onNext: { (venueAnnotations: [VenueAnnotation]) in
				
				let fakeJson = FakeJsonData.foursquareVenuesJson
				guard let responseObject = fakeJson["response"] as? [String: Any],
					let venuesObject = responseObject["venues"] as? [[String: Any]] else {
						XCTFail("Failed to cast venues object")
						return
				}
				
				XCTAssert(venueAnnotations.count == venuesObject.count)
				loadExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		viewModel.reloadMap(latitude: 0.0, longitude: 0.0)
		
		wait(for: [ loadExpectation ], timeout: 1.0)
	}
	
	func testLoadVenuesFailed() {
		
		let loadExpectation = expectation(description: "Expected 'onError' event called")
		
		let mockVenuesModel = MockVenuesModel(isSuccess: false)
		viewModel = HomeDefaultViewModel(venuesModel: mockVenuesModel)
		
		viewModel.loadVenuesFailed
			.subscribe(onNext: { (error: Error) in
				loadExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		viewModel.reloadMap(latitude: 0.0, longitude: 0.0)
		
		wait(for: [ loadExpectation ], timeout: 1.0)
	}
	
}
