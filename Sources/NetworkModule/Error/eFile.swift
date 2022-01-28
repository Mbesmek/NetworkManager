//
//  File.swift
//  
//
//  Created by Melih Bugra Esmek on 28.01.2022.
//

import Foundation
public struct NetworkService {
    
    public static let shared = NetworkService()
    public init() {}
    public static var tokenRequestAvailable = false
    
    let operationQueue: OperationQueue = OperationQueue()
    
    public func add(_ operation: Operation & NetworkOperationProtocol) {
        operation.operationState = .ready
        operationQueue.addOperation(operation)
    }
}

// Service Error Object
public struct ServiceErrorr: Codable {
    var errorKey: String?
    var title: String?
    var status: Int?
    var path: String?
}

// Service Error Cases
public enum NetworkError: Error {
    
    
    case operationFailed
    case connectionError
    case serviceError(ServiceErrorr)
    case error(Error)
    
    public var message: String? {
        switch self {
        case .operationFailed:
            return ErrorMessageConst.defaultConnectionErrorMessage
        case .connectionError:
            return ErrorMessageConst.defaultConnectionErrorMessage
        case .serviceError(let err):
            return err.errorKey
        case .error(_):
            return ErrorMessageConst.defaultErrorMessage
        }
    }
}

extension NetworkError {
    
    static func showAlert(with error: NetworkError) {
        
        let message = error.message ?? ErrorMessageConst.defaultErrorMessage
        let alert = UIAlertController(title: nil, message:message,  preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        guard let topController = UIApplication.shared.keyWindow?.rootViewController else {return}
        topController.present(alert, animated: true, completion: nil)
    }
}
