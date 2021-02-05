//
//  TVShowListModal.swift
//  TVShowList
//
//  Created by Rashma on 04/02/21.
//  Copyright © 2021 Reshma. All rights reserved.
//

import Foundation



struct struct_EachtvShow : Codable {
    
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
    var schedule : struct_schedule?
    var rating : struct_rating?
    var weight : Int?
    var network : struct_network?
    var externals : struct_externals?
    var image : struct_image?
    var summary : String?
    var updated : Int?
    var _links : struct_links?
    
    
}


struct struct_schedule : Codable {
    
    var time : String?
    var days : [String]?
    
}


struct struct_rating : Codable {
    
    var average : Double?
    
}


struct struct_network : Codable {
    
    var id : Int?
    var name : String?
    var country : struct_country?
    
}

struct struct_country : Codable {
    
    var name : String?
    var code : String?
    var timezone : String?
    
    
}

struct struct_externals : Codable {
    
    var tvrage : Int?
    var thetvdb : Int?
    var imdb : String?
}

struct struct_image : Codable {
    
    var medium : String?
    var original : String?
    
}


struct struct_links : Codable {
    
    var _self : struct_href?
    var previousepisode : struct_href?
    
    
}


struct struct_href : Codable {
    
    var href : String?
}

struct struct_searchedTVShowList : Codable {
    let show : struct_EachtvShow?
    
}



let baseURL = "https://api.tvmaze.com/"

struct ServiceNames {
    
    static let showPage                  = "shows?page=1"
    static let search                    = "search/shows?q="
    static let showSinglePage            = "shows/"
    static let showSeasons               = "shows/1/seasons"
    
}
