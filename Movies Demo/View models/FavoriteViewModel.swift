//
//  FavoriteViewModel.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
import UIKit
class FavoriteViewModel: BaseViewModel {
    private var favoriteData:Search!
    var bindFavoriteViewModel : (ConnectionStatus, String?) -> () = { status, reason in }
    var bindFavoriteRemoved : (ConnectionStatus, String?) -> () = { status, text in}

    var shouldLoad = false
    override init() {
        super.init()
        self.apiService = APIServices()
    }
    init(config:Config){
        super.init()
        self.apiService = APIServices()
        self.config = config
    }
    func getFavoriteData(page:Int){
        if page == Configs.firstPage{
            self.favoriteData = nil
        }
        self.apiService.getFavorites(page: page) { response in
            let tempData = response
            self.shouldLoad = tempData.page ?? 0 < tempData.total_pages ?? 0 ? true:false
            if(self.favoriteData == nil){
                self.favoriteData = tempData
            }else{
                self.favoriteData.results? += tempData.results!
                self.favoriteData.page = tempData.page
            }
            self.bindFavoriteViewModel(.completed, nil)
        } failure: { error in
            self.shouldLoad = false
            self.bindFavoriteViewModel(.failed, error?.localizedDescription)
        }
    }
    func refreshData(){
        self.favoriteData = nil
        getFavoriteData(page: Configs.firstPage)
    }
    func numberOfItems() -> Int{
        if self.favoriteData == nil { return 0 }
        return self.favoriteData.results?.count ?? 0
    }
    func setCellData(cell:MovieCollectionViewCell, index:Int){
        if self.favoriteData.results?.count ?? 0 > index{
            let data = self.favoriteData.results?[index]
//            cell.titleLabel.text = data?.title ?? ""
//            cell.descLabel.text = data?.release_date ?? ""
//            cell.ratingLabel.text = String(format:"%.1f/10", data?.vote_average ?? 0.0)
            cell.thumbnail.image = nil
            DispatchQueue.main.async {
                let urlString = self.getImageUrl(.thumbnail).appending((data?.poster_path ?? ""))
                cell.thumbnail.load(url:URL(string: urlString)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
                } failure: {
                    cell.thumbnail.image = UIImage(named: "movie-poster-placeholder")
                }
            }
        }
    }
    func removeClickedAt(index: Int){
        if self.favoriteData.results?.count ?? 0 > index{
            let data = self.favoriteData.results?[index]
            removeFavorite(movieId: data?.id ?? 0)
        }

    }
    func removeFavorite(movieId:Int){
        self.apiService.addToFavorite(movieId: movieId, favorite: false) { response in
            if response.success ?? true{
                if response.status_code == Configs.favoriteStatusCodeAdded{
                    self.bindFavoriteRemoved(.completed, response.status_message)
                }else{
                    self.bindFavoriteRemoved(.completed, response.status_message)
                }
            }else{
                self.bindFavoriteRemoved(.failed, response.status_message)
            }
        } failure: { error in
            self.bindFavoriteRemoved(.failed, error?.localizedDescription)
        }
    }
    func selectMovie(index:Int){
        self.selectedResult = self.favoriteData.results?[index]
    }
    func checkFavorite(movieId:Int?) -> Bool{
        if favoriteData == nil { return false }
        let contain = (self.favoriteData.results?.contains(where: { result in
            return result.id == movieId
        }))!
        return contain
    }
    func loadNext(){
        if self.shouldLoad{
            self.shouldLoad = false
            self.getFavoriteData(page: self.favoriteData.page! + 1)
        }
    }
    func getSelectedMovie() -> Result{
        return self.selectedResult
    }
}
