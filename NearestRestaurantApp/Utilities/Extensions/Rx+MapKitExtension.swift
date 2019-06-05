//
//  Rx+MapKitExtension.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import MapKit
import RxSwift
import RxCocoa

extension Reactive where Base: MKMapView {
	
	var delegate: DelegateProxy<MKMapView, MKMapViewDelegate> {
		return RxMKMapViewDelegateProxy.proxy(for: base)
	}
	
	var annotationSelected: Observable<MKAnnotationView?> {
		
		return delegate.methodInvoked(#selector(MKMapViewDelegate.mapView(_:didSelect:)))
			.map({ (obj: [Any]) -> MKAnnotationView? in
				
				guard let annotationView = obj[1] as? MKAnnotationView else {
					return nil
				}
				
				return annotationView
			})
	}
	
}
