//
//  MainCoordinator.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import UIKit
protocol DataPassing {
    func passDetailViewModel(_ detailViewModel: DetailViewModel, favoriteModel:FavoriteViewModel)
}
class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let modalTransitioningDelegate = ModalTransitioningDelegate()
    var rateDidClosed : (() -> ()) = {}
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    public func showDetail(_ detailViewModel:DetailViewModel, favoriteViewModel:FavoriteViewModel) {
        let vc = DetailViewController()
        vc.coordinator = self
        vc.detailViewModel = detailViewModel
        vc.favoriteViewModel = favoriteViewModel
        navigationController.pushViewController(vc, animated: true)

    }
    public func showFavorite(_ favoriteViewModel:FavoriteViewModel) {
        let vc = FavoriteViewController()
        vc.coordinator = self
        vc.favoriteViewModel = favoriteViewModel
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = modalTransitioningDelegate
        navigationController.present(vc, animated: true, completion: nil)
    }
    public func showRate(_ rateViewModel:RateViewModel) {
        let vc = RateViewController()
        vc.coordinator = self
        vc.rateViewModel = rateViewModel
        vc.didClosed = {
            self.rateDidClosed()
        }
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = modalTransitioningDelegate
        navigationController.present(vc, animated: true, completion: nil)
    }
    func dismissModal() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    func dismissAll(){
        navigationController.dismiss(animated: true, completion: nil)
        navigationController.popToRootViewController(animated: true)
    }
}
extension MainCoordinator:DataPassing{
    func passDetailViewModel(_ detailViewModel: DetailViewModel, favoriteModel:FavoriteViewModel){
        if let detailViewController = navigationController.topViewController as? DetailViewController {
            detailViewController.detailViewModel = detailViewModel
            detailViewController.favoriteViewModel = favoriteModel
        }
    }
}
