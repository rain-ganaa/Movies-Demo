//
//  RateViewModel.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//
import Foundation
import UIKit
class RateViewModel: BaseViewModel {
    var bindRateViewModel : (ConnectionStatus, String?) -> () = { status, reason in }
    var bindAddRating : (ConnectionStatus, String?) -> () = { status, reason in }
    var bindDeleteRating : (ConnectionStatus, String?) -> () = { status, reason in }
    var movie:Movie!
    var rating:Double!
    private var rateData:Search!
    init(movie:Movie?, config:Config){
        super.init()
        self.apiService = APIServices()
        self.movie = movie
        self.config = config

    }
    override init() {
        super.init()
        self.apiService = APIServices()
    }
    func setupContents(backgroundImageView:UIImageView, title: UILabel, thumbnailView:ThumbnailView){
        let urlString = self.getImageUrl(.poster).appending((self.movie.poster_path ?? ""))
        thumbnailView.thumbImageView.imageView.load(url:URL(string: urlString)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
            thumbnailView.thumbImageView.imageView.image = UIImage(named: "movie-poster-placeholder")
        } failure: {
        }
        backgroundImageView.load(url:URL(string: self.getImageUrl(.poster).appending((self.movie.backdrop_path ?? ""))
)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
            backgroundImageView.image = UIImage(named: "movie-poster-placeholder")
        } failure: {
        }
        title.text = self.movie.title
    }
    func getRatedMovies(){
        self.apiService.getRatedMovies() { response in
            self.rateData = response
            self.bindRateViewModel(.completed, nil)
        } failure: { error in
            self.bindRateViewModel(.failed, error?.localizedDescription)
        }
    }
    func ratingCaptured(rating:String){
        addRating(rating: rating)
    }
    func unrateCatured(){
        deleteRating()
    }
    func refresh(){
        self.getRatedMovies()
    }
    func addRating(rating:String){
        self.apiService.addRating(movieId: self.movie.id ?? 0, rating: rating) { response in
            if response.status_code == 1 {
                self.bindAddRating(.completed,nil)
            }else{
                self.bindAddRating(.failed,"Unexpected error!")
            }
            
        } failure: { error in
            self.bindAddRating(.failed,error?.localizedDescription)
        }

    }
    func deleteRating(){
        self.apiService.deleteRating(movieId: self.movie.id ?? 0) { response in
            self.bindDeleteRating(.completed,nil)
        } failure: { error in
            self.bindDeleteRating(.failed,error?.localizedDescription)

        }
    }
    func updateRateButton(button:RateButton){
        if let searchResults = rateData.results {
            if let movieResult = searchResults.first(where: { $0.id == self.movie.id }) {
                if let rating = movieResult.rating {
                    self.rating = rating
                    button.updateRateButtonAppearance(type: .rated, rating: "\(rating)")
                } else {
                    button.updateRateButtonAppearance(type: .rated, rating: "-")
                }
            } else {
                button.updateRateButtonAppearance(type: .notRated, rating: nil)
            }
        } else {
            button.updateRateButtonAppearance(type: .notRated, rating: nil)
        }

    }
    func setRated(button:RateButton){
        button.updateRateButtonAppearance(type: .rated, rating: "\(self.rating ?? 0)")
    }
}
