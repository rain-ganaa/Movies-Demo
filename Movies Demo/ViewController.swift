//
//  ViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import UIKit
import Foundation
class ViewController: BaseViewController{
    var tableView:UITableView!
    var headerView:HeaderView!
    var headerTopConstraint:NSLayoutConstraint!
    private var searchViewModel:SearchViewModel!
    private var favoriteViewModel:FavoriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        showNavigation(false)
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Configs.estimatedRowHeight
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieTableViewCell")
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
       
        headerView = HeaderView()
        headerView.label.text = "Popular Right now"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.searchBar.delegate = self
        self.view .addSubview(headerView)

        NSLayoutConstraint.activate([

            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            headerView.topAnchor.constraint(equalTo: self.view.topAnchor),

            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        headerTopConstraint = headerView.topAnchor.constraint(equalTo: self.view.topAnchor)
        headerTopConstraint.isActive = true
        callSearchViewModel()
    }
    func callSearchViewModel(){
        searchViewModel = SearchViewModel()
        searchViewModel.bindSearchViewModel = { status, reason in
            DispatchQueue.main.async {
                if status == .failed {
                    self.showDropAlert(title: nil, message: reason, type: .unsuccessful)
                }else{
                    self.tableView.reloadData()
                    self.callFavoriteViewModel()

                }
            }
        }
    }
    func callFavoriteViewModel(){
        print("callFavoriteViewModel")
        self.favoriteViewModel = self.searchViewModel.createFavoriteViewModel()
        self.favoriteViewModel.getFavoriteData(page: Configs.firstPage)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tableView.frame = view.bounds
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchViewModel == nil { return 0 }
        return self.searchViewModel.numberOfItems()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell
        else {
            return UITableViewCell()
        }
        self.searchViewModel.setCellData(cell: cell, index: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.searchViewModel.selectMovie(index: indexPath.row)
        coordinator?.showDetail(self.searchViewModel.createDetailViewModel(), favoriteViewModel: self.favoriteViewModel)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
extension ViewController: UIScrollViewDelegate,UISearchBarDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = self.tableView.contentOffset.y
        let differential = self.headerView.frame.size.height - offset
        if differential >= Configs.searchBarHeight{
            self.headerTopConstraint.constant = -self.tableView.contentOffset.y
            self.headerView.shrink(false)
        }else{
            var safeArea = 0.0 as CGFloat
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let windows = windowScene.windows
                safeArea = (windows.first?.safeAreaInsets.top)!
                // Use 'windows' as needed
            }

            self.headerTopConstraint.constant = -(self.headerView.frame.size.height - Configs.searchBarHeight - safeArea)
            self.headerView.shrink(true)
        }
        
        let height = self.tableView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = self.tableView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            self.searchViewModel.loadNext()
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        headerView.searchBar.endEditing(true)
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchViewModel.searchBarEdited(text: searchText)
    }
}
