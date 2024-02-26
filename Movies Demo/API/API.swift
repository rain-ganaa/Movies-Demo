//
//  API.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
import Foundation
class APIServices{
    func getUrlRequest(path:String,method:HTTPMethod) -> URLRequest{
        let url = Configs.host.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer " + Configs.apiToken, forHTTPHeaderField: "Authorization")
        return request
    }
    func getConfig(completion: @escaping (Config) -> (), failure:@escaping (Error?) -> ()){
        let request = getUrlRequest(path: Path().config, method: .GET)
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if((error) != nil){
                failure(error)
            }else if let data = data {
                let jsonDecoder = JSONDecoder()
                do{
                    let empData = try jsonDecoder.decode(Config.self, from: data)
                    completion(empData)
                }catch{
                    failure(nil)
                }
            }
        }
        task.resume()
    }
    func search(query:String?, page:Int, completion: @escaping (Search) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().search, method: .GET)
        let cache = URLCache()
        request.url?.append(queryItems: [URLQueryItem(name: Params().query, value: query ?? ""),
                                         URLQueryItem(name: Params().page, value: String(page)),
                                         URLQueryItem(name: Params().includeAdult, value: "false"),
                                         URLQueryItem(name: Params().language, value: "en-US")])
        let jsonDecoder = JSONDecoder()
        if let cacheData = cache.cachedResponse(for: request) {
            do{
                let empData = try jsonDecoder.decode(Search.self, from: cacheData.data)
                completion(empData)
            }catch{
                failure(nil)
            }
        }else{
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if((error) != nil){
                    failure(error)
                }else if let data = data {
                    do{
                        let empData = try jsonDecoder.decode(Search.self, from: data)
                        let cachedData = CachedURLResponse(response: urlResponse!, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        completion(empData)
                    }catch{
                        failure(nil)
                    }
                }
            }
            task.resume()
        }
    }
    func getMovieDetail(movieId:Int, completion: @escaping (Movie) -> (), failure:@escaping (Error?) -> ()){
        let request = getUrlRequest(path: Path().movie.appending("/\(movieId)"), method: .GET)
        let cache = URLCache()
        let jsonDecoder = JSONDecoder()
        if let cacheData = cache.cachedResponse(for: request) {
            do{
                let empData = try jsonDecoder.decode(Movie.self, from: cacheData.data)
                completion(empData)
            }catch{
                failure(nil)
            }
        }else{
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if((error) != nil){
                    failure(error)
                }else if let data = data {
                    do{
                        let empData = try jsonDecoder.decode(Movie.self, from: data)
                        let cachedData = CachedURLResponse(response: urlResponse!, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        completion(empData)
                    }catch{
                        failure(nil)
                    }
                }
            }
            task.resume()
        }
    }
    func getFavorites(page:Int, completion: @escaping (Search) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().favoriteList, method: .GET)
        request.url?.append(queryItems: [URLQueryItem(name: Params().sortBy, value:"created_at.asc"),
                                         URLQueryItem(name: Params().page, value: String(page)),
                                         URLQueryItem(name: Params().language, value: "en-US")])
        let jsonDecoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if((error) != nil){
                failure(error)
            }else if let data = data {
                do{
                    let empData = try jsonDecoder.decode(Search.self, from: data)
                    completion(empData)
                }catch{
                    failure(nil)
                }
            }
        }
        task.resume()
    }
    func addToFavorite(movieId:Int, favorite:Bool, completion: @escaping (Favorite) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().favorite, method: .POST)
        let json: [String: Any] = [Params().mediaType: "movie",
                                   Params().mediaId: String(movieId),
                                   Params().favorite: favorite]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if((error) != nil){
                    failure(error)
                }else if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let empData = try jsonDecoder.decode(Favorite.self, from: data)
                        completion(empData)
                    }catch{
                        failure(nil)
                    }
                }
            }
            task.resume()
        } catch {
            failure(error)
        }
    }
    func getRatedMovies(completion: @escaping (Search) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().rated, method: .GET)
        let cache = URLCache()
        request.url?.append(queryItems: [URLQueryItem(name: Params().language, value: "en-US")])
        let jsonDecoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            if((error) != nil){
                failure(error)
            }else if let data = data {
                do{
                    let empData = try jsonDecoder.decode(Search.self, from: data)
                    let cachedData = CachedURLResponse(response: urlResponse!, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    completion(empData)
                }catch{
                    failure(nil)
                }
            }
        }
        task.resume()
    }
    func addRating(movieId:Int, rating:String, completion: @escaping (AddRating) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().rating.replacingOccurrences(of: "{movie_id}", with: "\(movieId)"), method: .POST)
        let json: [String: Any] = [Params().value: rating]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            request.httpBody = jsonData
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if((error) != nil){
                    print("failure\(error?.localizedDescription)")
                    failure(error)
                }else if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        print("empData")
                        let empData = try jsonDecoder.decode(AddRating.self, from: data)
                        completion(empData)
                    }catch{
                        print("catch")
                        failure(nil)
                    }
                }
            }
            task.resume()
        } catch {
            failure(error)
        }
    }
    func deleteRating(movieId:Int, completion: @escaping (AddRating) -> (), failure:@escaping (Error?) -> ()){
        var request = getUrlRequest(path: Path().rating.replacingOccurrences(of: "{movie_id}", with: "\(movieId)"), method: .DELETE)
        do {
            let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
                if((error) != nil){
                    failure(error)
                }else if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let empData = try jsonDecoder.decode(AddRating.self, from: data)
                        completion(empData)
                    }catch{
                        failure(nil)
                    }
                }
            }
            task.resume()
        } catch {
            failure(error)
        }
    }
}
enum HTTPMethod:String {
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
}
struct Path {
    public let search = "/3/search/movie"
    public let favoriteList = "/3/account/\(Configs.userId)/favorite/movies"
    public let config = "/3/configuration"
    public let favorite = "/3/account/\(Configs.userId)/favorite"
    public let rating = "3/movie/{movie_id}/rating"
    public let movie = "/3/movie"
    public let rated = "/3/account/\(Configs.userId)/rated/movies"
}
struct Params{
    public let query = "query"
    public let includeAdult = "include_adult"
    public let language = "language"
    public let primaryReleaseYear = "primary_release_year"
    public let page = "page"
    public let region = "region"
    public let year = "year"
    
    public let mediaType = "media_type"
    public let mediaId = "media_id"
    public let favorite = "favorite"
    public let sortBy = "sort_by"
    
    public let movieId = "movie_id"
    public let value = "value"
}
