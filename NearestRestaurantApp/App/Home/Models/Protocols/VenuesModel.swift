//
//  VenuesModel.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

protocol VenuesModel {
	
	func fetch(with request: VenuesRequest) -> Observable<[VenueDetail]>
	
}
