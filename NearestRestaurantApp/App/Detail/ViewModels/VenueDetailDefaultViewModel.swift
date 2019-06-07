//
//  VenueDetailDefaultViewModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

final class VenueDetailDefaultViewModel : VenueDetailViewModel {
	
	var venueName: Observable<String> {
		return _venueName.asObservable()
	}
	var venuePhotos: Observable<[String]> {
		return _venuePhotos.asObservable()
	}
	var venueAddress: Observable<String> {
		return _venueAddress.asObservable()
	}
	var loadVenueError: Observable<Error> {
		return _loadVenueError.asObservable()
	}
	
	private let disposeBag = DisposeBag()
	private let _venueName: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
	private let _venuePhotos: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [String]())
	private let _venueAddress: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
	private let _loadVenueStarted: PublishSubject<Void> = PublishSubject()
	private let _loadVenueError: PublishSubject<Error> = PublishSubject()
	
	private let venueId: String
	private let venueDetailModel: VenueDetailModel
	
	init(venueId: String, venueDetailModel: VenueDetailModel) {
		
		self.venueId = venueId
		self.venueDetailModel = venueDetailModel
		
		bindUserInteractions()
	}
	
	func reloadData() {
		_loadVenueStarted.onNext(())
	}
	
	private func bindUserInteractions() {
		
		_loadVenueStarted.asObservable()
			.subscribe(onNext: getVenueDetail)
			.disposed(by: disposeBag)
	}
	
	private func getVenueDetail() {
		
		venueDetailModel.getDetail(by: venueId)
			.subscribe(
				onNext: setVenueDetail,
				onError: _loadVenueError.onNext
			)
			.disposed(by: disposeBag)
	}
	
	private func setVenueDetail(from venue: VenueDetail) {
		
		_venueName.accept(venue.name)
		_venuePhotos.accept(venue.getVenueImageURLs())
		
		if let address = venue.location?.formattedAddress.joined(separator: ", ") {
			_venueAddress.accept(address)
		}
	}
}
