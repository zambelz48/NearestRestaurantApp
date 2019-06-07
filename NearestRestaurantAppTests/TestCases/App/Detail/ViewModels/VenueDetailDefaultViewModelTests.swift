//
//  VenueDetailDefaultViewModelTests.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest
import RxSwift

class VenueDetailDefaultViewModelTests: XCTestCase {

	private var disposeBag: DisposeBag!
	private var viewModel: VenueDetailViewModel!
	
    override func setUp() {
		super.setUp()
		
		disposeBag = DisposeBag()
    }

    override func tearDown() {
		
		viewModel = nil
		
		disposeBag = nil
		
		super.tearDown()
    }
	
	func testSuccessfulGetVenueDetail() {
		
		let venueNameExpectation = expectation(description: "Expected got the venue name")
		let venuePhotosExpectation = expectation(description: "Expected got the venue photos")
		let venueAddressExpectation = expectation(description: "Expected got the venue address")
		
		let mockVenueDetailModel = MockVenueDetailModel(isSuccess: true)
		viewModel = VenueDetailDefaultViewModel(venueId: "venue-123", venueDetailModel: mockVenueDetailModel)
		viewModel.reloadData()
		
		viewModel.venueName
			.subscribe(onNext: { (venueName: String) in
				XCTAssert(venueName == "Foodcourt BMI")
				venueNameExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		viewModel.venuePhotos
			.subscribe(onNext: { (venuePhotos: [String]) in
				XCTAssert(venuePhotos.count == 1)
				venuePhotosExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		viewModel.venueAddress
			.subscribe(onNext: { (venueAddress: String) in
				XCTAssert(venueAddress == "Komp. Bumi Manjahlega Indah (Margahayu, Metro), Bandung, Jawa Barat, Indonesia")
				venueAddressExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		wait(for: [
			venueNameExpectation,
			venuePhotosExpectation,
			venueAddressExpectation
		], timeout: 3.0)
	}
	
	func testFailedGetVenueDetail() {
		
		let loadExpectation = expectation(description: "Expected 'onError' event called")
		
		let mockVenueDetailModel = MockVenueDetailModel(isSuccess: false)
		viewModel = VenueDetailDefaultViewModel(venueId: "venue-123", venueDetailModel: mockVenueDetailModel)
		
		viewModel.loadVenueError
			.subscribe(onNext: { (error: Error) in
				loadExpectation.fulfill()
			})
			.disposed(by: disposeBag)
		
		viewModel.reloadData()
		
		wait(for: [ loadExpectation ], timeout: 1.0)
	}

}
