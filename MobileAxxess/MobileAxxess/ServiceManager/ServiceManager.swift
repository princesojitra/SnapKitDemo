//
//  ServiceManager.swift
//  MobileAxxess
//
//  Created by Prince Sojitra on 01/08/20.
//  Copyright © 2020 Prince Sojitra. All rights reserved.
//

import Foundation
import Alamofire


class ServiceManager{
    
    static let sharedInstance = ServiceManager()
    let session = Alamofire.SessionManager.default
    
    // Fetch data from the server with dynamic codeable model
    func serviceRequest<T:Endpoint,U:Decodable>(with endpoint:T, decodingType:U.Type?) {
        
        print("******* API Log ******")
        print("URL : ", endpoint.path)
        print("Method : ", endpoint.method)
        print("Params : ", endpoint.parameter ?? [:])
        print("Headers : \(ServiceManager.httpsHeaders(with: endpoint.authorizedToken))")
        
        guard endpoint.path != "" else {
            endpoint.resultCompletion?(.failure(.requestFailed))
            return
        }
        
        if endpoint.showLoader {
            CustomLoader.shared.showLoader(color:AppColor.Color_NavyBlue)
        }
        
        // Session request with endpoint details
        session.request(endpoint.path, method: endpoint.method, parameters: endpoint.parameter, encoding: endpoint.encoding, headers: ServiceManager.httpsHeaders(with: endpoint.authorizedToken)).responseJSON { (response) in
            
            if endpoint.showLoader {
                CustomLoader.shared.hideLoader()
            }
            
            switch response.result {
            case .failure(_):
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response failure : \(responseString)")
                    print("******* API Log ******")
                }
                endpoint.resultCompletion?(.failure(ServiceError.requestFailed))
                break
            case .success(let responseValue):
                print("Response:",responseValue)
                print("******* API Log ******")
                if let data = response.data {
                    if let decodeType = decodingType {
                        if let genricResponseModel =  ServiceManager.decodeResponse(dataToDeocde: data, decodingType: decodeType) {
                            endpoint.resultCompletion?(.success(genricResponseModel))
                        }
                        else{
                            endpoint.resultCompletion?(.failure(ServiceError.invalidData))
                        }
                    }
                    else{
                        endpoint.resultCompletion?(.failure(ServiceError.invalidData))
                    }
                    print("******* API Log ******")
                }
                
                break
            }
        }
        
    }
    
    //Set headers
    class func httpsHeaders(with token: String?) -> HTTPHeaders {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        if let token = token {
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        return defaultHeaders
    }
    
    // Decode data into specified datamodel
    class func decodeResponse<T:Decodable>(dataToDeocde:Data,decodingType:T.Type) -> T? {
        
        do {
            let genericModel = try JSONDecoder().decode(decodingType, from: dataToDeocde)
            return genericModel
        } catch {
            return nil
        }
    }
    
}
