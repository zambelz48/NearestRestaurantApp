//
//  HttpHandler+Extension.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation
import RxSwift

extension HttpHandler {
	
	func jsonRequest<T>(spec: HttpRequestSpec, onSuccess: @escaping (T?) -> (), onFailed: @escaping (CommonError) -> () = { _ in })
		where T: Codable {
			
			var requestSpec = spec
			requestSpec.appendHeader(key: "Content-Type", value: "application/json")
			
			return request(spec: requestSpec, onSuccess: onSuccess, onFailed: onFailed)
	}
	
	func requestObservable<T>(spec: HttpRequestSpec) -> Observable<T> where T: Codable {
		
		return Observable
			.create({ [weak self] (observer: AnyObserver<T?>) -> Disposable in
				
				self?.request(
					spec: spec,
					onSuccess: { (result: T?) in
						observer.onNext(result)
						observer.onCompleted()
					},
					onFailed: { (error: CommonError) in
						observer.onError(error)
						observer.onCompleted()
					}
				)
				
				return Disposables.create()
			})
			.filter({ (result: T?) -> Bool in
				return result != nil
			})
			.map({ (result: T?) -> T in
				
				guard let validResult = result else {
					return (T.self as! T)
				}
				
				return validResult
			})
	}
	
	func jsonRequestObservable<T>(spec: HttpRequestSpec) -> Observable<T> where T: Codable {
		
		var requestSpec = spec
		requestSpec.appendHeader(key: "Content-Type", value: "application/json")
		
		return requestObservable(spec: requestSpec)
	}
	
	func foursquareRequestObservable<T>(spec: HttpRequestSpec) -> Observable<T> where T: Codable {
		
		let observable: Observable<FoursquareResponse<T>> = jsonRequestObservable(spec: spec)
		
		return observable
			.concatMap({ (result: FoursquareResponse<T>) -> Observable<T> in
				return .from(optional: result.response)
			})
			.catchError({ (error: Error) -> Observable<T> in
				
				guard let commonError = error as? CommonError,
					let errorData = commonError.message.data(using: .utf8) else {
						return .error(error)
				}
				
				do {
					
					let errorDictionary = try JSONSerialization.jsonObject(with: errorData, options: []) as? [String: Any]
					
					guard let meta = errorDictionary?["meta"] as? [String: Any],
						let code = meta["code"] as? Int,
						let errorType = meta["errorType"] as? String,
						let errorDetail = meta["errorDetail"] as? String else {
							return .error(error)
					}
					
					let foursquareError = NSError(
						domain: errorType,
						code: code,
						userInfo: [ NSLocalizedDescriptionKey : errorDetail ]
					)
					
					return .error(foursquareError)
					
				} catch {
					return .error(error)
				}
			})
	}
	
}
