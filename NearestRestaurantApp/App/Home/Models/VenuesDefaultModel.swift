//
//  VenuesDefaultModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class VenuesDefaultModel : VenuesModel {
	
	private let httpHandler: HttpHandler
	
	init(urlSession: URLSessionStandard) {
		httpHandler = HttpHandler.sharedInstance(session: urlSession)
	}
	
	func fetch(with request: VenuesRequest) -> Observable<[VenueDetail]> {
		
		let endpoint = VenuesEndpoint.fetch.rawValue
		
		var spec = HttpRequestSpec(url: endpoint)
		spec.appendParameters(key: "client_id", value: Config.foursquareClientID)
		spec.appendParameters(key: "client_secret", value: Config.foursquareSecretKey)
		spec.appendParameters(key: "v", value: Config.foursquareApiVersion)
		spec.appendParameters(key: "query", value: "food")
		spec.appendParameters(key: "ll", value: "\(request.latitude),\(request.longitude)")
		spec.appendParameters(key: "radius", value: "\(request.radius)")
		
		let requestObservable: Observable<Venues> = httpHandler.foursquareRequestObservable(spec: spec)
		
		return requestObservable.concatMap({ (venues: Venues) -> Observable<[VenueDetail]> in
			return Observable.from(optional: venues.venues)
		})
	}
	
}
