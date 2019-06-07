//
//  VenueDetailModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol VenueDetailModel {
	
	func getDetail(by venueId: String) -> Observable<VenueDetail>
	
}
