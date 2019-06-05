//
//  RxMKMapViewDelegateProxy.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

final class RxMKMapViewDelegateProxy: DelegateProxy<MKMapView, MKMapViewDelegate>, MKMapViewDelegate, DelegateProxyType {
	
	static func currentDelegate(for mapView: MKMapView) -> MKMapViewDelegate? {
		return mapView.delegate
	}
	
	static func setCurrentDelegate(_ delegate: MKMapViewDelegate?, to mapView: MKMapView) {
		mapView.delegate = delegate
	}
	
	
	static func registerKnownImplementations() {
		self.register { (mapView: MKMapView) -> RxMKMapViewDelegateProxy in
			return RxMKMapViewDelegateProxy(parentObject: mapView, delegateProxy: self)
		}
	}
}
