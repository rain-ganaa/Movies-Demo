//
//  File.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
import UIKit
class SearchViewModel: BaseViewModel {
    private var searchData:Search!
    var bindSearchViewModel : (ConnectionStatus, String?) -> () = { status, reason in }
    var bindConfig : (ConnectionStatus) -> () = { status in }
    var shouldLoad = false
    var searchText:String!
    override init() {
        super.init()
        self.apiService = APIServices()
        getConfig()
//        getInitialData()
    }
    func getConfig(){
        apiService.getConfig { response in
            self.config = response
            self.bindConfig(.completed)
            
        } failure: { error in
            self.bindConfig(.failed)
            print(error!)
        }
    }
    func getInitialData(){
        searchData = nil
        searchText = ""
        searchMovie(title: "Australia", page: Configs.firstPage)
    }
    func searchMovie(title:String, page:Int){
        self.apiService.search(query: title, page: page) { response in
            let tempData = response
            self.shouldLoad = tempData.page ?? 0 < tempData.total_pages ?? 0 ? true:false
            if(self.searchData == nil){
                self.searchData = tempData
            }else{
                self.searchData.results? += tempData.results!
                self.searchData.page = tempData.page
            }
            self.bindSearchViewModel(.completed, nil)
        } failure: { error in
            self.shouldLoad = false
            self.bindSearchViewModel(.failed, error?.localizedDescription)
        }
    }
    func searchBarEdited(text:String){
        searchData = nil
        searchText = text
        searchMovie(title: text, page: Configs.firstPage)
    }
    func numberOfItems() -> Int{
        if self.searchData == nil { return 0 }
        return self.searchData.results?.count ?? 0
    }
    func setCellData(cell:MovieTableViewCell, index:Int){
        if self.searchData != nil && self.searchData.results?.count ?? 0 > index{
            let data = self.searchData.results?[index]
            cell.titleLabel.text = data?.title ?? ""
            let dateString = data?.release_date ?? ""
            let components = dateString.split(separator: "-")
            if let year = components.first {
                cell.descLabel.text = ("\(year)")
            }

//            cell.descLabel.text = data?.release_date ?? ""
            let decimalNumber = (data?.vote_average)!
            let percentage = Int(decimalNumber * 10)
            let percentString = String(format:"\(percentage)")
            cell.ratingLabel.text = percentString + "%"
            cell.thumbnail.image = nil
            cell.userScoreLabel.text = "user score"
            DispatchQueue.main.async {
                let urlString = self.getImageUrl(.thumbnail).appending((data?.poster_path ?? ""))
                cell.thumbnail.load(url:URL(string: urlString)!, placeholder: UIImage(named: "movie-poster-placeholder"), cache: URLCache()) {
                } failure: {
                    cell.thumbnail.image = UIImage(named: "movie-poster-placeholder")
                }
            }
            
        }
    }
    func selectMovie(index:Int){
        self.selectedResult = self.searchData.results?[index]
    }
    func loadNext(){
        if self.shouldLoad{
            self.shouldLoad = false
            self.searchMovie(title: self.searchText, page: self.searchData.page! + 1)
        }
    }
    func getSelectedMovie() -> Result{
        return self.selectedResult
    }
    func createFavoriteViewModel() -> FavoriteViewModel{
        return FavoriteViewModel(config:self.config)
    }
    public func getConfigData() -> Config{
        return self.config
    }
    public func showPlaceHolder() -> Bool{
        if searchData == nil { return true }
        return self.searchData.total_results == 0 ? true:false
    }
}
