//
//  FavoriteViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit

class FavoriteViewController: ChildViewController {
    var favoriteViewModel:FavoriteViewModel!
    var collectionView:UICollectionView!
    var searchButton:TextButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.view.backgroundColor = (UIColor(hex: "FFFFFF", alpha: 1))
        showNavigation(true)
        navigationBar.setBackgroundColor(UIColor(hex: "8EEAA2", alpha: 1))
        navigationBar.setBackButtonTitle("Back")
        navigationBar.setButtonTintColor(UIColor(hex: "000000", alpha: 1))
        titleLabel.text = "My favourites"
        titleLabel.textColor = UIColor(hex: "347868", alpha: 1)
        self.view.bringSubviewToFront(scrollView)
        self.view.bringSubviewToFront(navigationBar)
        backgroundTransparentView.isHidden = true
    
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal // Set the scroll direction as per your requirement
        layout.minimumLineSpacing = 33 // Set the minimum line spacing between items
        layout.minimumInteritemSpacing = 33 // Set the minimum interitem spacing between items
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)

        searchButton = TextButton()
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.setLabel(backgroundColor: UIColor(hex: "EFEFEF", alpha: 1), textColor: UIColor(hex: "000000", alpha: 1), text: "Search for More")
        self.view.addSubview(searchButton)

        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor, constant:35),
            
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 245),
            
            searchButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 56),
            searchButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -99)

        ])
        callFavoriteViewModel()
        
    }
    @objc func searchButtonTapped() {
        coordinator?.dismissAll()
    }
    func callFavoriteViewModel(){
        self.favoriteViewModel.bindFavoriteViewModel = { status, reason in
            DispatchQueue.main.async {
                self.collectionView.allowsSelection = true
                if status == .failed {
                    self.showDropAlert(title: nil, message: reason, type: .unsuccessful)
                }else{
                    self.collectionView.reloadData()
                }
            }
        }
        self.favoriteViewModel.bindFavoriteRemoved = { status, reason in
            DispatchQueue.main.async {
                self.favoriteViewModel.refreshData()
                if status == .failed {
                    self.showDropAlert(title: nil, message: reason, type: .unsuccessful)
                }else{
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
extension FavoriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if favoriteViewModel == nil { return 0 }
        return self.favoriteViewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        favoriteViewModel.setCellData(cell: cell, index: indexPath.item)
        cell.buttonActionHandler = {
               // Perform actions when the button is tapped in the cell
            self.favoriteViewModel.removeClickedAt(index: indexPath.item)
        }
           
        cell.updateConstraints()
        return cell
    }
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection
    }
}
extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size of the item at the specified index path
        return CGSize(width: 120, height: 245)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 0)
        // Return the inset for the specified section
    }
}
extension FavoriteViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.collectionView.frame.size.height
        let contentXoffset = scrollView.contentOffset.x
        let distanceFromRight = self.collectionView.contentSize.width - contentXoffset
        if distanceFromRight < width {
    //        self.favoriteViewModel.loadNext()
            print("load next")
        }
    }
}

