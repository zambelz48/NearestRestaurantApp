//
//  HomeViewController.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 06/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {

	@IBOutlet private weak var mainMapView: MKMapView!
	
	private let locationManager: CLLocationManager = CLLocationManager()
	
	private let disposeBag = DisposeBag()
	
	private var viewModel: HomeViewModel?
	
	init(viewModel: HomeViewModel) {
		
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		configureMapView()
		configureLocationManager()
		
		bindViewModel()
		bindMapInteractions()
    }
	
	private func configureMapView() {
		
		mainMapView.delegate = self
		mainMapView.showsUserLocation = true
	}
	
	private func centerMap(to coordinate: CLLocationCoordinate2D) {
		
		let distance = 1500
		let coordinateRegion = MKCoordinateRegion(
			center: coordinate,
			latitudinalMeters: CLLocationDistance(distance),
			longitudinalMeters: CLLocationDistance(distance)
		)
		
		mainMapView.setRegion(coordinateRegion, animated: true)
	}
	
	private func configureLocationManager() {
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		if (CLLocationManager.authorizationStatus() == .notDetermined) {
			locationManager.requestAlwaysAuthorization()
		}
	}
	
	private func bindMapInteractions() {
		
		mainMapView.rx.annotationSelected
			.subscribe(onNext: { (annotationView: MKAnnotationView?) in
				
				guard let annotation = annotationView?.annotation as? VenueAnnotation else {
					return
				}
				
				// TODO: Show venue detail from here, later on
				print("selected venue: \(annotation.address)")
			})
			.disposed(by: disposeBag)
	}
	
	private func bindViewModel() {
		
		viewModel?.loadVenuesSuccess
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] (venues: [VenueAnnotation]) in
				venues.forEach({ (venue: VenueAnnotation) in
					self?.mainMapView.addAnnotation(venue)
				})
			})
			.disposed(by: disposeBag)
		
		viewModel?.loadVenuesFailed
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { (error: Error) in
				// TODO: Handle error later
			})
			.disposed(by: disposeBag)
	}

}

extension HomeViewController : MKMapViewDelegate { }

extension HomeViewController : CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
		guard let coordinate = manager.location?.coordinate else {
			return
		}
		
		centerMap(to: coordinate)
		
		viewModel?.reloadMap(latitude: coordinate.latitude, longitude: coordinate.longitude)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard let coordinate = manager.location?.coordinate else {
			return
		}
		
		viewModel?.reloadMap(latitude: coordinate.latitude, longitude: coordinate.longitude)
	}
	
	func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
		
		let coordinate = mapView.centerCoordinate
		
		viewModel?.reloadMap(latitude: coordinate.latitude, longitude: coordinate.longitude)
	}
	
}
