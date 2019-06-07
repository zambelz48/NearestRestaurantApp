//
//  UIImageView+Extension.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 07/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
	
	func load(from urlString: String) {
		
		let loadingView = UIActivityIndicatorView(style: .whiteLarge)
		loadingView.startAnimating()
		
		addSubview(loadingView)
		
		loadingView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
			loadingView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		let httpHandler = HttpHandler.sharedInstance(session: URLSession.defaultConfig())
		let spec = HttpRequestSpec(url: urlString)
		
		httpHandler.request(
			spec: spec,
			onSuccess: { (data: Data?) in
				
				guard let data = data else {
					return
				}
				
				DispatchQueue.main.async { [weak self] in
					
					loadingView.removeFromSuperview()
					
					self?.contentMode = .scaleToFill
					self?.image = UIImage(data: data)
				}
			},
			onFailed: { (error: Error) in
				DispatchQueue.main.async {
					loadingView.removeFromSuperview()
				}
			}
		)
	}
	
}
