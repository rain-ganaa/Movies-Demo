//
//  Constants.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import Foundation
import UIKit
class Configs{
    //API
    static let host = URL(string:"https://api.themoviedb.org")!
    static let apiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNWY5YTdiMDk2ZmYyOTg1MzQ2Nzc1ZDhiOTgzZGYyZiIsInN1YiI6IjY0OTExN2Y3MjYzNDYyMDBlYjc3YTQ1NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Ifc0Wc54OQxxPJI5zUSVziNg9-LM2gXx4JDGydl0Uoo"
    static let apiKey = "15f9a7b096ff2985346775d8b983df2f"
    static let userId = "20036414"
    
    static let favoriteStatusCodeAdded = 1
    static let favoriteStatusCodeRemoved = 13
    static let firstPage = 1

    
    //TableView
    static let thumbnailHeight = 131.0
    static let thumbnailWidth = 85.0
    static let estimatedRowHeight = thumbnailHeight + 20.0
    static let contentMargin = 24.0
    
    //Searchbar
    static let searchBarHeight = 43.0
    static let searchBarMargin = 37.0
    
    static let navigationBarHeight = 84.0

}
enum Fonts:String{
    case interRegular = "Inter-Regular"
    case interBold = "Inter-Bold"
    case jomhuria = "Jomhuria-Regular"
}
class Strings{
    static let buttonTitleFavorite = "Add to Favorites"
    static let buttonTitleUnFavorite = "Remove from Favorites"
    
    static let unExpectedError = "Unexpected Error"
    static let searchNoResult = "No results - try other terms"
    static let favoriteEmpty = "Favorite list is empty"
}

