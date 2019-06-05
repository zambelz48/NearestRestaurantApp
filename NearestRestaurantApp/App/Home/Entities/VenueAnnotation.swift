//
//  VenueAnnotation.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import MapKit

final class VenueAnnotation : NSObject, MKAnnotation {
	
	let id: String
	let locationName: String
	let address: String
	
	var coordinate: CLLocationCoordinate2D
	
	var title: String? {
		return locationName
	}
	
	var subtitle: String? {
		return address
	}
	
	init(id: String, locationName: String, address: String, latitude: Double, longitude: Double) {
		
		self.id = id
		self.locationName = locationName
		self.address = address
		self.coordinate = CLLocationCoordinate2D(
			latitude: CLLocationDegrees(latitude),
			longitude: CLLocationDegrees(longitude)
		)
		
		super.init()
	}

}
