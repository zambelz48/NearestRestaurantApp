//
//  MockVenuesModel.swift
//  NearestRestaurantAppTests
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class MockVenuesModel : VenuesModel {
	
	private let isSuccess: Bool
	
	init(isSuccess: Bool) {
		self.isSuccess = isSuccess
	}
	
	func fetch(with request: VenuesRequest) -> Observable<[VenueDetail]> {
		
		if (isSuccess) {
			return successObservable()
		}
		
		return failedObservable()
	}
	
	private func successObservable() -> Observable<[VenueDetail]> {
		
		let fakeJson = FakeJsonData.foursquareVenuesJson
		guard let responseObject = fakeJson["response"] as? [String: Any],
			let venuesObject = responseObject["venues"] as? [[String: Any]] else {
				return .error(ErrorFactory.unknown.detail)
		}
		
		do {
			
			let venues = try venuesObject.compactMap({ (venue: [String : Any]) -> VenueDetail in
				
				let decoder = JSONDecoder()
				let data = try JSONSerialization.data(withJSONObject: venue, options: .prettyPrinted)
				let result = try decoder.decode(VenueDetail.self, from: data)
				
				return result
			})
			
			return .from(optional: venues)
			
		} catch let parsingError {
			return .error(ErrorFactory.from(parsingError).detail)
		}
	}
	
	private func failedObservable() -> Observable<[VenueDetail]> {
		
		let error = ErrorFactory.custom(code: -1, message: "Failed to retrieve venues").detail
		
		return .error(error)
	}
	
}
