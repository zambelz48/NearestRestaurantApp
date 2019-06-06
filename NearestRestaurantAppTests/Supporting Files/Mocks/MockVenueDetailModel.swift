//
//  MockVenueDetailModel.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class MockVenueDetailModel : VenueDetailModel {
	
	private let isSuccess: Bool
	
	init(isSuccess: Bool) {
		self.isSuccess = isSuccess
	}
	
	func getDetail(by venueId: String) -> Observable<VenueDetail> {
		
		if (isSuccess) {
			return successObservable()
		}
		
		return failedObservable()
	}
	
	private func successObservable() -> Observable<VenueDetail> {
		
		let fakeJson = FakeJsonData.foursquareVenueDetailJson
		guard let responseObject = fakeJson["response"] as? [String: Any],
			let venueObject = responseObject["venue"] as? [String: Any] else {
				return .error(ErrorFactory.unknown.detail)
		}
		
		do {
			
			let decoder = JSONDecoder()
			let data = try JSONSerialization.data(withJSONObject: venueObject, options: .prettyPrinted)
			let venue = try decoder.decode(VenueDetail.self, from: data)
			
			return .from(optional: venue)
			
		} catch let parsingError {
			return .error(ErrorFactory.from(parsingError).detail)
		}
	}
	
	private func failedObservable() -> Observable<VenueDetail> {
		
		let error = ErrorFactory.custom(code: -1, message: "Failed to retrieve venues").detail
		
		return .error(error)
	}
}
