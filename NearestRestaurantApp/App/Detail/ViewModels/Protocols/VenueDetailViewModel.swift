//
//  VenueDetailViewModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol VenueDetailViewModel {
	
	var venueName: Observable<String> { get }
	
	var venuePhotos: Observable<[String]> { get }
	
	var venueAddress: Observable<String> { get }
	
	var loadVenueError: Observable<Error> { get }
	
	func reloadData()
}
