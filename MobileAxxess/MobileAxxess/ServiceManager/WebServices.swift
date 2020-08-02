//
//  WebServices.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import Alamofire

typealias Parameters = [String:Any]
typealias ResponseBody = Any
typealias ReesultComplitionBlock = (Result<Decodable?,ServiceError>) -> Void
typealias HTTPHeaders = [String: String]

//Error types
enum ServiceError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}

//Service method types
enum ServiceMethodType : String{
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
}

//Server types
enum ServerType {
    case Development
    case Staging
    case Production
    var baseUrl:String {
        switch self {
        case .Development:
            return "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/"
        case .Staging:
            return "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/"
        case .Production:
            return "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/"
        }
    }
}

//Response Type
enum Result<T, U> where U: Error  {
    case success(T)
    case failure(U)
}

//Endpoints requirements
protocol EndPointProtocol {
    var path: String { get set }
    var method: HTTPMethod  { get set }
    var parameter: Parameters?  { get set }
    var resultCompletion: ReesultComplitionBlock?  { get set }
}


//Endpoints details
class Endpoint :EndPointProtocol {
    var path: String = ""
    var method: HTTPMethod
    var parameter: Parameters?
    var resultCompletion: ReesultComplitionBlock?
    var showLoader: Bool = true
    var authorizedToken: String?
    var encoding: ParameterEncoding = URLEncoding.default
    
    init(path: String, method: HTTPMethod = .get, parameter: Parameters? = nil, authToken: String? = nil,encoding: ParameterEncoding = URLEncoding.default, showLoader: Bool = true ,  completion: @escaping ReesultComplitionBlock) {
        self.path = path
        self.method = method
        self.parameter = parameter
        self.resultCompletion = completion
        self.showLoader = showLoader
        self.authorizedToken = authToken
        self.encoding = encoding
    }
    
}


// Webservices used in applictaion
enum WebService {
    
    //Get deployement server type
    static var server :ServerType {
        return ServerType.Development
    }
    
    //Get baseurl based on server type
    static var baseUrl:String {
        return server.baseUrl
    }
    
    // SwiftArticle WebService
    private static let SwiftArticles = WebService.baseUrl + "challenge.json"
    static func FetchSwiftArticles(completion: @escaping ReesultComplitionBlock) {
        let endpoint = Endpoint(path: SwiftArticles, method: .get, parameter: nil, authToken: nil, encoding: URLEncoding.default, showLoader: true, completion: completion)
        ServiceManager.sharedInstance.serviceRequest(with: endpoint, decodingType: [Articles].self)
    }
}
