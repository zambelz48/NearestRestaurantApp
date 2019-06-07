//
//  NearestRestaurantAppUITests.swift
//  NearestRestaurantAppUITests
//
//  Created by Nanda Julianda Akbar on 04/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import XCTest

class NearestRestaurantAppUITests: XCTestCase {

	private var app: XCUIApplication!
	
    override func setUp() {
		super.setUp()
		
		app = XCUIApplication()
		
        continueAfterFailure = false
    }

    override func tearDown() {
		
		app = nil
		
		super.tearDown()
    }

    func testApp() {
		
		app.launch()
		
		let map = app.maps.element(boundBy: 0)
		let isMapExists = map.waitForExistence(timeout: 5.0)
		
		XCTAssert(isMapExists)
    }

}
