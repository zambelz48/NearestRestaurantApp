//
//  HomeDefaultViewModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

final class HomeDefaultViewModel : HomeViewModel {
	
	var loadVenuesSuccess: Observable<[VenueAnnotation]> {
		return _loadVenuesSuccess.asObservable()
	}
	var loadVenuesFailed: Observable<Error> {
		return _loadVenuesFailed.asObservable()
	}
	
	private let disposeBag = DisposeBag()
	private let _loadVenuesStarted: PublishSubject<(Double, Double)> = PublishSubject()
	private let _loadVenuesSuccess: PublishSubject<[VenueAnnotation]> = PublishSubject()
	private let _loadVenuesFailed: PublishSubject<Error> = PublishSubject()
	
	private let radius: Double = 700
	private let venuesModel: VenuesModel
	
	init(venuesModel: VenuesModel) {
		
		self.venuesModel = venuesModel
		
		bindUserInteractions()
	}
	
	func reloadMap(latitude: Double, longitude: Double) {
		_loadVenuesStarted.onNext((latitude, longitude))
	}
	
	private func bindUserInteractions() {
		
		_loadVenuesStarted
			.throttle(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance)
			.subscribe(onNext: loadVenues)
			.disposed(by: disposeBag)
	}
	
	private func loadVenues(latitude: Double, longitude: Double) {
		
		let request = VenuesRequest(
			latitude: latitude,
			longitude: longitude,
			radius: radius
		)
		
		venuesModel.fetch(with: request)
			.concatMap({ (venues: [VenueDetail]) -> Observable<VenueDetail> in
				return .from(venues)
			})
			.filter({ (venue: VenueDetail) -> Bool in
				
				return (
					!venue.id.isEmpty &&
					venue.location?.lat != nil &&
					venue.location?.lng != nil
				)
			})
			.map({ (venue: VenueDetail) -> VenueAnnotation in
				
				let address = venue.location?.formattedAddress.joined(separator: ", ") ?? ""
				
				return VenueAnnotation(
					id: venue.id,
					locationName: venue.name,
					address: address,
					latitude: venue.location!.lat,
					longitude: venue.location!.lng
				)
			})
			.toArray()
			.asObservable()
			.subscribe(
				onNext: _loadVenuesSuccess.onNext,
				onError: _loadVenuesFailed.onNext
			)
			.disposed(by: disposeBag)
	}
}
