//
//  DetailViewModel.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//
import UIKit
import Foundation
class DetailViewModel: BaseViewModel {
    var bindFavorite : (ConnectionStatus, String?) -> () = { status, text in}
    var bindDetailViewModel : (ConnectionStatus, String?) -> () = { status, text in}
    var movie:Movie!{
        didSet{
            self.bindDetailViewModel(.completed, nil)
        }
    }
    var isFavorite:Bool!
    override init() {
        super.init()
        self.apiService = APIServices()
    }
    init(result:Result?, config:Config){
        super.init()
        self.apiService = APIServices()
        self.selectedResult = result
        self.config = config
    }
    func getMovieDetail(){
        self.apiService.getMovieDetail(movieId: self.selectedResult.id!) { response in
            self.movie = response
        } failure: { error in
            self.bindDetailViewModel(.failed, error?.localizedDescription)
        }
    }
    func setBackground(imageView:UIImageView){
        let urlString = self.getImageUrl(.poster).appending((selectedResult.poster_path ?? ""))
        imageView.load(url:URL(string: urlString)!, placeholder: nil, cache: URLCache()) {
        } failure: {
        }
    }
    func setupContents(backgroundImageView:UIImageView, posterImageView:UIImageView, titleLabel:UILabel, informationView:InformationView, overView:UILabel){
        let urlString = self.getImageUrl(.poster).appending((self.movie.poster_path ?? ""))
        posterImageView.load(url:URL(string: urlString)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
            posterImageView.image = UIImage(named: "movie-poster-placeholder")
        } failure: {
        }
        backgroundImageView.load(url:URL(string: self.getImageUrl(.poster).appending((self.movie.backdrop_path ?? ""))
)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
            posterImageView.image = UIImage(named: "movie-poster-placeholder")
        } failure: {
        }
        titleLabel.text = self.movie.title
        informationView.titleLabel.text = self.movie.title
        
        let genres = self.movie.genres?.map {$0.name!}.joined(separator: " ")
        informationView.genreLabel.text = genres
        
        let dateString = self.movie?.release_date ?? ""
        let components = dateString.split(separator: "-")
        if let year = components.first {
            informationView.descLabel.text = ("\(year)")
        }
        
        let decimalNumber = (self.movie?.vote_average)!
        print("percent decimal:\(decimalNumber)")
        informationView.percentView.setPercent(CGFloat(decimalNumber/10))

        let percentage = Int(decimalNumber * 10)
        let percentString = String(format:"\(percentage)")
        
        informationView.ratingLabel.text = percentString + "%"
        overView.text = self.movie.overview
        informationView.sizeToFit()
    }
    func getMovieId()->Int{
        return self.selectedResult.id ?? 0
    }
    func checkItemFavorited() -> Bool{
        return self.isFavorite
    }
    func setFavorite(favoriteViewModel:FavoriteViewModel){
        self.isFavorite = favoriteViewModel.checkFavorite(movieId: self.selectedResult.id)
    }
    func sendFavorite(){
        self.apiService.addToFavorite(movieId: selectedResult.id ?? 0, favorite: !self.isFavorite) { response in
            if response.success ?? true{
                if response.status_code == Configs.favoriteStatusCodeAdded{
                    self.bindFavorite(.completed, response.status_message)
                    self.isFavorite = true
                }else{
                    self.bindFavorite(.completed, response.status_message)
                    self.isFavorite = false
                }
            }else{
                self.bindFavorite(.failed, response.status_message)
            }
        } failure: { error in
            self.bindFavorite(.failed, error?.localizedDescription)
        }
    }
    
    func createRateViewModel() -> RateViewModel{
        return RateViewModel(movie: self.movie, config: self.config)
    }
}
