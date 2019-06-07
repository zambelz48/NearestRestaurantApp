//
//  VenueDetailViewController.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import UIKit
import RxSwift

final class VenueDetailViewController: UIViewController {

	enum Event {
		case back
	}
	
	var onEvent: ((Event) -> ())?
	
	@IBOutlet private weak var venuePhoto: UIImageView!
	@IBOutlet private weak var venueNameLabel: UILabel!
	@IBOutlet private weak var venueAddressLabel: UILabel!
	
	private let disposeBag = DisposeBag()
	private var viewModel: VenueDetailViewModel?
	
	init(viewModel: VenueDetailViewModel) {
		
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		configureViewController()
		
		bindViewModel()
		
		reloadData()
    }
	
	private func configureViewController() {
		
		self.title = "Venue Detail"
		
		let leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
		leftBarButtonItem.rx.tap
			.subscribe(onNext: { [weak self] in
				self?.onEvent?(.back)
			})
			.disposed(by: disposeBag)
		
		self.navigationItem.leftBarButtonItem = leftBarButtonItem
	}
	
	private func reloadData() {
		viewModel?.reloadData()
	}
	
	private func bindViewModel() {
		
		viewModel?.venueName
			.observeOn(MainScheduler.instance)
			.bind(to: venueNameLabel.rx.text)
			.disposed(by: disposeBag)
		
		viewModel?.venueAddress
			.observeOn(MainScheduler.instance)
			.bind(to: venueAddressLabel.rx.text)
			.disposed(by: disposeBag)
		
		viewModel?.venuePhotos
			.observeOn(MainScheduler.instance)
			.map({ (photos: [String]) -> String in
				
				guard let photoURL = photos.first else {
					return ""
				}
				
				return photoURL
			})
			.filter({ (photoURL: String) -> Bool in
				return !photoURL.isEmpty
			})
			.subscribe(onNext: venuePhoto.load)
			.disposed(by: disposeBag)
	}

}
