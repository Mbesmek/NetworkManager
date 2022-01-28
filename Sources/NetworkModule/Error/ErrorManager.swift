//
//  ErrorManager.swift
//  
//
//  Created by Melih Bugra Esmek on 28.01.2022.
//

import Foundation



public struct ServiceErrorr: Codable {
    var errorKey: String?
    var title: String?
    var status: Int?
    var path: String?
}

public enum ServiceErrorr: Error {
    case operationFailed
    case connectionError
    case serviceError(ServiceErrorr)
    case error(Error)

    public var message: String {
        switch self {
        case .handledError(let error):
            return error.title
        case .decoding:
            return ErrorMessageEnum.decodingErrorMessage
        case .networkError:
            return ErrorMessageEnum.defaultErrorMessage
        case .timeout:
            return ErrorMessageEnum.timeoutErrorMessage
        case .message(let message):
            return message
        }
}


    public var debugMessage: String {
        switch self {
        case .handledError(let error):
            return error.detail
        case .decoding(let decodingError):
            guard let decodingError = decodingError else { return ErrorMessageEnum.decodingErrorMessage }
            return "\(decodingError)"
        case .networkError:
            return ErrorMessageEnum.connectionErrorMessage
        case .timeout:
            return ErrorMessageEnum.timeoutErrorMessage
        case .message(let message):
            return message
        }
    }
}
