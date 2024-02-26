//
//  Movie.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
class Movie:Codable{
    var adult:Bool?
    var backdrop_path:String?
    var belongs_to_collection:BelongsToCollection?
    var budget:Int?
    var genres:[Genre]?
    var homepage:String?
    var id:Int?
    var imdb_id:String?
    var original_language:String?
    var original_title:String?
    var overview:String?
    var popularity:Float
    var poster_path:String?
    var production_companies:[ProductionCompany]?
    var production_countries:[ProductionCountry]?
    var release_date:String?
    var revenue:Int
    var runtime:Int
    var spoken_languages:[SpokenLanguage]?
    var status:String?
    var tagline:String?
    var title:String?
    var video:Bool?
    var vote_average:Float?
    var vote_count:Int?
    var rating:Float?
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case belongs_to_collection
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case production_companies
        case production_countries
        case release_date
        case revenue
        case runtime
        case spoken_languages
        case status
        case tagline
        case title
        case video
        case vote_average
        case vote_count
    }
}
struct BelongsToCollection:Codable{
    var id:Int
    var name:String?
    var poster_path:String?
    var backdrop_path:String?
}
struct Genre:Codable{
    var id:Int
    var name:String?
}
struct ProductionCompany:Codable{
    var id:Int
    var logo_path:String?
    var name:String?
    var origin_country:String?
}
struct ProductionCountry:Codable{
    var iso_3166_1:String?
    var name:String?
}
struct SpokenLanguage:Codable{
    var english_name:String?
    var iso_639_1:String?
    var name:String?
}
