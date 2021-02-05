//
//  TVShowListModal.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import Foundation



struct struct_ShowDetails : Codable {
    
    var id : Int?
    var url : String?
    var name : String?
    var type : String?
    var language : String?
    var genres : [String]?
    var status : String?
    var runtime : Int?
    var premiered : String?
    var officialSite : String?
    var schedule : struct_showDetailsschedule?
    var rating : struct_showDetailsrating?
    var weight : Int?
    var network : struct_showDetailsnetwork?
    var externals : struct_showDetailsexternals?
    var image : struct_showdetailsimage?
    var summary : String?
    var updated : Int?
    var _links : struct_showDetailslinks?
    
    
}


struct struct_showDetailsschedule : Codable {
    
    var time : String?
    var days : [String]?
    
}


struct struct_showDetailsrating : Codable {
    
    var average : Double?
    
}


struct struct_showDetailsnetwork : Codable {
    
    var id : Int?
    var name : String?
    var country : struct_showDetailscountry?
    
}

struct struct_showDetailscountry : Codable {
    
    var name : String?
    var code : String?
    var timezone : String?
    
    
}

struct struct_showDetailsexternals : Codable {
    
    var tvrage : Int?
    var thetvdb : Int?
    var imdb : String?
}

struct struct_showdetailsimage : Codable {
    
    var medium : String?
    var original : String?
    
}


struct struct_showDetailslinks : Codable {
    
    var _self : struct_showDetailshref?
    var previousepisode : struct_showDetailshref?
    
    
}


struct struct_showDetailshref : Codable {
    
    var href : String?
}

