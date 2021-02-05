//
//  APIServices.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import Foundation
import Alamofire

class APIServices : NSObject {
    
    typealias onComplete = ( _ response:AnyObject?, _ success:Bool?) -> Void
       
       static let sharedInstance:APIServices = {
           let instance = APIServices()
           return instance
       }()
       
       
func callAPI(_urlString:String,headers:HTTPHeaders,bodyData:[String:Any],Httpmethod:HTTPMethod,block:@escaping onComplete) {
        
    
    AF.request(_urlString, method: Httpmethod, parameters: bodyData, encoding: URLEncoding.default, headers: headers).responseJSON { response in
               switch response.result{
               case .success( _):
                   //print(value)
                block (response.data as AnyObject,true)
                   break
               case .failure( let error ):
                   block(error as AnyObject as AnyObject, false)
                   break
               }
           }

     }
    
    
    
    
    
    

    
    
    
}


class NetworkConnectivity {
    class func isConnectedToInternet() -> Bool {
       return NetworkReachabilityManager()!.isReachable
    }
}
