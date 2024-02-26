//
//  BaseViewModel.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit
enum ConnectionStatus:String {
    case `default`
    case fetching
    case completed
    case failed
}
enum ImageType:String{
    case thumbnail
    case poster
    case backround
}
class BaseViewModel: NSObject {
    var apiService:APIServices!
    var connectionStatus:ConnectionStatus! = .default
    var fetched:Bool = false
    var selectedResult:Result!
    public var config:Config!
    func getImageUrl(_ imageType:ImageType) -> String{
        switch imageType {
        case .thumbnail:
            return String("\(self.config.images?.base_url ?? "")w342")
        case .backround:
            return String("\(self.config.images?.base_url ?? "")w185")
        case .poster:
            return String("\(self.config.images?.base_url ?? "")w500")
        }
    }
    func createDetailViewModel() -> DetailViewModel{
        return DetailViewModel(result: self.selectedResult, config:self.config)
    }
    func minuteToHourAndMinutes(minutes:Int) -> String{
        let hours = minutes / 60
        let totalminutes = minutes % 60
        if hours == 0 {
            return ("\(totalminutes)m")
        }else{
            return ("\(hours)h \(totalminutes)m")
        }
    }
}
extension UIImageView {
    func load(url: URL ,completion: @escaping () -> (), failure:@escaping () -> ()) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        completion()
                        self?.image = image
                    }
                }else{
                    failure()
                }
            }else{
                failure()
            }
        }
    }
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil,completion: @escaping () -> (), failure:@escaping () -> ()) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                print("image loaded from cache")
                self.image = image
            }
        }else{
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        print("image loaded from server")
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
