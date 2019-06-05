//
//  HomeViewModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeViewModel {
	
	var loadVenuesSuccess: Observable<[VenueAnnotation]> { get }
	
	var loadVenuesFailed: Observable<Error> { get }
	
	func reloadMap(latitude: Double, longitude: Double)
}
