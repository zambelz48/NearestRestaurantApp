//
//  ErrorFactory.swift
//  NearestRestaurantApp
//
//  Created by Nanda Julianda Akbar on 05/06/19.
//  Copyright © 2019 Nanda Julianda Akbar. All rights reserved.
//

import Foundation

enum ErrorType {
	
	case httpInvalidSpec
	case httpError(code: Int)
	
	var code: Int {
		
		switch self {
			
		case .httpInvalidSpec:
			return -2
			
		case .httpError(let code):
			return code
			
		}
		
	}
}

enum ErrorFactory : Error {
	
	case unknown
	case from(_ error: Error)
	case string(_ str: String?)
	case dictionary(_ dict: [String: Any]?)
	case custom(code: Int, message: String)
	case by(type: ErrorType)
	
}

extension ErrorFactory {
	
	var detail: CommonError {
		
		switch self {
		
		case .from(let error):
			
			return CommonError(code: -4, message: error.localizedDescription)
			
		case .string(let str):
			
			guard let validErrorStr = str else {
				return ErrorFactory.unknown.detail
			}
			
			return CommonError(code: -3, message: validErrorStr)
			
		case .dictionary(let data):
			
			guard let validErrorData = data else {
				return ErrorFactory.unknown.detail
			}
			
			return CommonError(code: -2, message: String(describing: validErrorData))
			
		case .custom(let code, let message):
			
			return CommonError(code: code, message: message)
			
		case .unknown:
			
			let errorCode = -1
			let errorMessage = self.localizedDescription
			
			return CommonError(code: errorCode, message: errorMessage)
			
		case .by(let type):
			
			let errorCode = type.code
			let errorMessage = getErrorMessage(for: type)
			
			return CommonError(code: errorCode, message: errorMessage)
			
		}
		
	}
	
	private func getErrorMessage(for type: ErrorType) -> String {
		
		switch type {
			
		case .httpInvalidSpec:
			return "Invalid http request spec"
			
		case .httpError(let code):
			return HTTPURLResponse.localizedString(forStatusCode: code)
			
		}
		
	}
	
}
