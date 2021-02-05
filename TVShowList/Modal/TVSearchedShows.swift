//
//  TVShowListModal.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import Foundation


struct struct_AllSearchedTVShows : Codable {
    var score : Double?
    var show : struct_EachSearchedtvShow?
    
}



struct struct_EachSearchedtvShow : Codable {
    
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
    var schedule : struct_searchedschedule?
    var rating : struct_searchedrating?
    var weight : Int?
    var network : struct_searchednetwork?
    var externals : struct_searchedexternals?
    var image : struct_searchedimage?
    var summary : String?
    var updated : Int?
    var _links : struct_searchedlinks?
    
    
}


struct struct_searchedschedule : Codable {
    
    var time : String?
    var days : [String]?
    
}


struct struct_searchedrating : Codable {
    
    var average : Double?
    
}


struct struct_searchednetwork : Codable {
    
    var id : Int?
    var name : String?
    var country : struct_searchedcountry?
    
}

struct struct_searchedcountry : Codable {
    
    var name : String?
    var code : String?
    var timezone : String?
    
    
}

struct struct_searchedexternals : Codable {
    
    var tvrage : Int?
    var thetvdb : Int?
    var imdb : String?
}

struct struct_searchedimage : Codable {
    
    var medium : String?
    var original : String?
    
}


struct struct_searchedlinks : Codable {
    
    var _self : struct_searchedhref?
    var previousepisode : struct_searchedhref?
    
    
}


struct struct_searchedhref : Codable {
    
    var href : String?
}




