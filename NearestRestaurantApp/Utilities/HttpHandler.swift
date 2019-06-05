//
//  HttpHandler.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

final class HttpHandler {
	
	private let session: URLSessionStandard
	
	private init(session: URLSessionStandard) {
		self.session = session
	}
	
	static internal func sharedInstance(session: URLSessionStandard) -> HttpHandler {
		return HttpHandler(session: session)
	}
	
	func request(spec: HttpRequestSpec, onSuccess: @escaping (Data?) -> (), onFailed: @escaping (CommonError) -> () = { _ in }) {
		
		guard let request = configureRequest(with: spec) else {
			let error = ErrorFactory.by(type: .httpInvalidSpec).detail
			onFailed(error)
			return
		}
		
		let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
			
			if let validError = error {
				let errorDetail = ErrorFactory.from(validError).detail
				onFailed(errorDetail)
				return
			}
			
			guard let validData = data, let validResponse = response as? HTTPURLResponse else {
				let error = ErrorFactory.unknown.detail
				onFailed(error)
				return
			}
			
			let statusCode = validResponse.statusCode
			
			if (statusCode >= 200 && statusCode < 300 && !validData.isEmpty) {
				onSuccess(validData)
				return
			}
			
			guard let errorString = String(data: validData, encoding: .utf8) else {
				
				let errorType = ErrorType.httpError(code: statusCode)
				let errorDetail = ErrorFactory.by(type: errorType).detail
				
				onFailed(errorDetail)
				
				return
			}
			
			let errorDetail = ErrorFactory.string(errorString).detail
			
			onFailed(errorDetail)
		}
		
		task.resume()
	}
	
	func request<T>(spec: HttpRequestSpec, onSuccess: @escaping (T?) -> (), onFailed: @escaping (CommonError) -> () = { _ in })
		where T: Codable {
			
			request(
				spec: spec,
				onSuccess: { (data: Data?) in
					
					guard let validData = data, !validData.isEmpty else {
						return
					}
					
					let decoder = JSONDecoder()
					
					do {
						
						let successData = try decoder.decode(T.self, from: validData)
						
						onSuccess(successData)
						
					} catch let error {
						let errorDetail = ErrorFactory.from(error).detail
						onFailed(errorDetail)
					}
					
				},
				onFailed: onFailed
			)
	}
	
	private func configureRequest(with spec: HttpRequestSpec) -> URLRequest? {
		
		guard let targetURL = URL(string: spec.url) else {
			return nil
		}
		
		var request = URLRequest(url: targetURL)
		request.httpMethod = spec.method.rawValue
		
		spec.headers.forEach ({ (key: String, value: String) in
			request.setValue(value, forHTTPHeaderField: key)
		})
		
		switch (!spec.parameters.isEmpty, spec.method) {
			
		case (true, .get):
			
			var urlComponents = URLComponents(string: spec.url)
			urlComponents?.queryItems = spec.parameters.map ({ (key: String, value: Any) -> URLQueryItem in
				return URLQueryItem(name: key, value: value as? String)
			})
			request.url = urlComponents?.url
			
		case (true, .post), (true, .put):
			let httpBody = try? JSONSerialization.data(withJSONObject: spec.parameters)
			request.httpBody = httpBody
			
		default:
			break
			
		}
		
		return request
	}
	
}
