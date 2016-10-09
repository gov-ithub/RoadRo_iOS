//
//  DataProvider+Network.swift
//  SkiRomania
//
//  Created by Mihai Dumitrache on 08/10/2016.
//  Copyright © 2016 Work In Progress. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension DataProvider {
  
  func initNetworkManager() {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    self.manager = Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
  }
  
  func successHandler(value: Data, response: HTTPURLResponse?, completionHandler: DataResponseHandler?) {
    let data = JSON(data: value )
    
    if let handler = completionHandler {
      var errorMessage : String?
      if let msg = data["error"]["message"].string {
        errorMessage = msg
        DLog(object: "API ERROR: \(errorMessage)")
      }
      handler(data["response"], errorMessage)
    }
  }
  
  func errorHandler(error: Error?, completionHandler: DataResponseHandler?) {
    if let handler = completionHandler {
      var errorMessage = self.kGenericError
      if let errorMsg = (error as? NSError)?.localizedDescription as String? {
        errorMessage = errorMsg
      }
      DLog(object: "API ERROR: \(errorMessage)")
      handler(nil, errorMessage)
    }
  }
  
  func performRequest(method: Alamofire.HTTPMethod, path: String, params: [String: Any]?, completionHandler: DataResponseHandler?) -> Cancelable? {
    
    var url = path
    if !url.hasPrefix("http") {
      url = self.kNetworkApiURL + path
    }
    
    var params = params
    if let access_token = self.authorizationDataSource?.dataProviderAccessToken() {
      params?["access_token"] = access_token
    }
    
    DLog(object: "API URL: \(url)")
    DLog(object: "API PARAMS: \(params)")
    
    // Authorization header
    let headers: [String : String]? = ["Content-Type": "application/json"]
    
    let encoding = Alamofire.JSONEncoding.default
    let request = self.manager.request(url, method: method, parameters: params, encoding: encoding, headers: headers)
    
    .validate(statusCode: 200..<500)
    .validate(contentType: ["application/json"])
    .responseData { (response) in
      switch response.result {
      case .success(let value):
        self.successHandler(value: value, response: response.response, completionHandler: completionHandler)
      case .failure(let error):
        self.errorHandler(error: error, completionHandler: completionHandler)
      }
    }
    
    return request
  }
}
