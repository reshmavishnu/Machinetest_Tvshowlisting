//
//  TVShowListView.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import Foundation
import CoreData
import  UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let managedContext = appDelegate.persistentContainer.viewContext


protocol protocol_TVShowListView {
    func passResult(result : Any)
}


class TVShowListView : NSObject {
    
    
    typealias onComplete = ( _ success:Bool?, _ error:String?) -> Void

    typealias completionResult = (_ response:Any?, _ success:Bool?) -> Void
    
    var delegate : protocol_TVShowListView?
    
    
    func callAPI(url_ : String, search : Bool, isforListing : Bool, completion:@escaping completionResult) {
        
        APIServices.sharedInstance.callAPI(_urlString: url_, headers: [:], bodyData: [:], Httpmethod: .get) { (result, status) in
            
            if status == true {
                
                guard let responseData = result else { return }
                
                do {
                    let decoder = JSONDecoder()
                    if isforListing == true {
                    
                    if search == false {
                        let list = try decoder.decode([struct_EachtvShow].self, from: responseData as! Data)
                        self.delegate?.passResult(result: list)
                        completion(list, true)
                    }
                    else {
                        let list = try decoder.decode([struct_AllSearchedTVShows].self, from: responseData as! Data)
                        self.delegate?.passResult(result: list)
                        completion(list, true)
                    }
                    } else {
                        let details = try decoder.decode(struct_ShowDetails.self, from: responseData as! Data)
                        self.delegate?.passResult(result: details)
                        completion(details, true)
                    }
                    
                } catch let error {
                    print(error)
                    self.delegate?.passResult(result: "FAILED")
                    completion(nil, false)
                }
                
                
                
                
            }
            
            
            
        }
        
        
        
    }
    
    
    func saveRatingsToCoreData(ID : Int, rating : Double) {
        
        
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TVShowRating")
            fetchRequest.predicate = NSPredicate(format: "id = %i ",argumentArray: [ID])
            do {
                let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
                if results?.count != 0 {
                    ((results?[0])!).setValue(rating, forKey: "rating")
                    try managedContext.save()
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "TVShowRating",in: managedContext)!
                    let currentShow = NSManagedObject(entity: entity,insertInto: managedContext)
                    currentShow.setValue(ID, forKeyPath: "id")
                    currentShow.setValue(rating, forKeyPath: "rating")
                    
                    do {
                        try managedContext.save()
                       // print(eachForm)
                    }
                    catch
                    {
                        
                    }
                }
               
            }
            catch
            {
            }
            
    }
    
    
    func getStarRatinedValue(ID : Int) -> Double {
        var RATING : Double = 0.0
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TVShowRating")
        fetchRequest.predicate = NSPredicate(format: "id = %i ",argumentArray: [ID])
        do {
            let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 {
                RATING =  results?[0].value(forKey: "rating") as! Double
            } else {
                RATING =  0.0
            }
           
        }
        catch
        {
        }
        return RATING
    }
    
}
