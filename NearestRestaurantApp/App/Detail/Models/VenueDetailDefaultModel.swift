//
//  VenueDetailDefaultModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class VenueDetailDefaultModel : VenueDetailModel {
	
	private let httpHandler: HttpHandler
	
	init(urlSession: URLSessionStandard) {
		httpHandler = HttpHandler.sharedInstance(session: urlSession)
	}
	
	func getDetail(by venueId: String) -> Observable<VenueDetail> {
		
		let endpoint = VenueDetailEndpoint.getDetail(venueId: venueId).rawValue
		
		var spec = HttpRequestSpec(url: endpoint)
		spec.constructFoursquareRequestSpec()
		
		let observable: Observable<Venue> = httpHandler.foursquareRequestObservable(spec: spec)
		
		return observable.concatMap({ (venue: Venue) -> Observable<VenueDetail> in
			return .of(venue.venue)
		})
	}
	
}
