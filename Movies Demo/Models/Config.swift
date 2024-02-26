//
//  Config.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
class Config:Codable{
    struct Image:Codable{
        var base_url:String? = ""
        var secure_base_url:String? = ""
        var backdrop_sizes:[String]
        var logo_sizes:[String?]
        var poster_sizes:[String?]
        var profile_sizes:[String?]
        var still_sizes:[String?]
    }
    var images:Image?
    var change_keys:[String]?
    private enum CodingKeys: String, CodingKey {
        case images
        case change_keys
    }
}
