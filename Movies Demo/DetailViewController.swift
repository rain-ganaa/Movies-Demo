//
//  DetailViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import UIKit

class DetailViewController: ChildViewController {
    var thumbnailView:ThumbnailView!
    var informationView:InformationView!
    var contentsView:UIView!
    var rateButton:RateButton!
    var favsButton:TextButton!
    var detailViewModel:DetailViewModel!
    var favoriteViewModel:FavoriteViewModel!
    var rateViewModel:RateViewModel!
    var didClosed : (() -> ()) = {}

    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 16)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()!
    func callDetailViewModel(){
        self.detailViewModel.setFavorite(favoriteViewModel: self.favoriteViewModel)
        self.detailViewModel.bindFavorite = { status, reason in
            DispatchQueue.main.async {
                self.animateButton(enable: true)
                self.updateFavoriteButton()
                if status == .completed{
                    self.showDropAlert(title: nil, message: reason, type: .successful)
                }else{
                    self.showDropAlert(title: nil, message: reason, type: .unsuccessful)
                }
            }
        }
        self.detailViewModel.bindDetailViewModel = { status, reason in
            DispatchQueue.main.async {
                if status == .completed{
                    self.setupContents()
                    self.callRateViewModel()
                    self.updateFavoriteButton()

                }else{
                    self.showDropAlert(title: nil, message: reason, type: .unsuccessful)
                }
            }
        }
        self.detailViewModel.getMovieDetail()
    }
    func callRateViewModel(){
        rateViewModel = detailViewModel.createRateViewModel()
        rateViewModel.bindRateViewModel = { status, reason in
            DispatchQueue.main.async {
                if status == .completed{
                    self.rateViewModel.updateRateButton(button: self.rateButton)
                }
            }
        }
        rateViewModel.bindAddRating = { status, reason in
            DispatchQueue.main.async {
                self.rateButton.isEnabled = true
                if status == .completed{
                    self.coordinator?.showRate(self.rateViewModel)
                }
            }
        }
        rateViewModel.bindDeleteRating = { status, reason in
            DispatchQueue.main.async {
                if status == .completed{
                    print("completed")
                    self.rateViewModel.refresh()
                }
            }
        }
        rateViewModel.getRatedMovies()
    }
    
    func setupContents(){
        detailViewModel.setupContents(backgroundImageView:backgroundImage, posterImageView: thumbnailView.thumbImageView.imageView, titleLabel:titleLabel, informationView: informationView, overView: descriptionLabel)
    }
    func updateFavoriteButton(){
        thumbnailView.favoriteButton.icon.image = self.detailViewModel.checkItemFavorited() ? UIImage(named: "starClicked"):UIImage(named: "favorite")
    }
    func animateButton(enable:Bool){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.thumbnailView.favoriteButton.alpha = enable ? 1:0.8
        } completion: { completed in
            self.thumbnailView.favoriteButton.isEnabled = enable
        }
    }
    func setupBlurImageView(){
        detailViewModel.setBackground(imageView: self.backgroundImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigation(true)
        navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationBar.setBackButtonTitle("Back to Search")
        navigationBar.setButtonTintColor(UIColor(hex: "FFFFFF", alpha: 1))
        navigationBar.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        self.view.bringSubviewToFront(scrollView)
        self.view.bringSubviewToFront(navigationBar)
        titleLabel.textColor = UIColor(hex: "FFFFFF", alpha: 1)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true
        setupContentsView()
        setupScrollView()
        callDetailViewModel()
        thumbnailView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    func setupContentsView() {
        contentsView = UIView()
        contentsView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 1)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentsView)
        
        thumbnailView = ThumbnailView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(thumbnailView)
        
        informationView = InformationView()
        informationView.translatesAutoresizingMaskIntoConstraints = false
        contentsView.addSubview(informationView)

        informationView.userScoreLabel.text = "user score"
        
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        contentsView.addSubview(buttonContainer)
        
        rateButton = RateButton()
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        buttonContainer.addSubview(rateButton)
        
        favsButton = TextButton()
        favsButton.translatesAutoresizingMaskIntoConstraints = false
        favsButton.addTarget(self, action: #selector(favsButtonTapped), for: .touchUpInside)
        favsButton.setLabel(backgroundColor: UIColor(hex: "FFF3D3", alpha: 1), textColor: UIColor(hex: "B98E1E", alpha: 1), text: "View Favs")
        buttonContainer.addSubview(favsButton)
        
        let label: UILabel = {
            let label = UILabel()
            label.font(.interBold, size: 16)
            label.textColor = UIColor(hex: "000000", alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Overview"
            return label
        }()
        let paddingView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = contentsView.backgroundColor
            return view
        }()
        contentsView.addSubview(label)
        contentsView.addSubview(descriptionLabel)
        contentsView.addSubview(paddingView)
        NSLayoutConstraint.activate([
            
            backgroundImage.bottomAnchor.constraint(equalTo: contentsView.topAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: self.navigationBar.backButton.bottomAnchor, constant:18),
            
            thumbnailView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -10),
            thumbnailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 37),
            
            contentsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentsView.topAnchor.constraint(equalTo: thumbnailView.topAnchor, constant:82),
            contentsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentsView.heightAnchor.constraint(equalToConstant: 300),
            
            informationView.topAnchor.constraint(equalTo: contentsView.topAnchor, constant: 6),
            informationView.leadingAnchor.constraint(equalTo: thumbnailView.thumbImageView.trailingAnchor, constant: 20),
            informationView.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: 24),
            
            buttonContainer.leadingAnchor.constraint(equalTo: thumbnailView.leadingAnchor),
            buttonContainer.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 27),
            buttonContainer.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant:-8),
            
            rateButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            rateButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            rateButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            rateButton.heightAnchor.constraint(equalToConstant: 56),
            rateButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            favsButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            favsButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            favsButton.leadingAnchor.constraint(equalTo: rateButton.trailingAnchor, constant:10),
            favsButton.trailingAnchor.constraint(greaterThanOrEqualTo: buttonContainer.trailingAnchor, constant:8),
            favsButton.heightAnchor.constraint(equalToConstant: 56),
            favsButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 145),

            label.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant:33),
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37),
            label.heightAnchor.constraint(equalToConstant: 18),
            
            descriptionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant:14),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 37),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -37),
//            descriptionLabel.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
//            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor),
            
            paddingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            paddingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            paddingView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            paddingView.bottomAnchor.constraint(equalTo: contentsView.bottomAnchor),
            paddingView.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor),

//            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(contentsView.bounds.size.width, contentsView.bounds.size.height)
        coordinator?.rateDidClosed = {
            self.rateViewModel.getRatedMovies()
        }
    }
    @objc func rateButtonTapped() {
        if rateButton.type == .notRated{
            showAlertWithTextField(nil)
        }else if rateButton.type == .rated{
            self.rateViewModel.deleteRating()
        }
    }
    @objc func favoriteButtonTapped() {
        self.animateButton(enable: false)
        self.detailViewModel.sendFavorite()
    }
    @objc func favsButtonTapped() {
        coordinator?.showFavorite(self.favoriteViewModel)
    }
    func showAlertWithTextField(_ text:String?) {
        let alertController = UIAlertController(title: "Enter Rating", message: text == nil ? "Please enter a value between 1 and 10":text, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "1-10"
            textField.keyboardType = .decimalPad
        }
        let okAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            if let textField = alertController.textFields?.first {
                // Access the text entered by the user
                if let ratingText = textField.text, let rating = Double(ratingText), (1...10).contains(rating) {
                    self.rateButton.updateRateButtonAppearance(type: .rating, rating: nil)
                    self.rateButton.isEnabled = false
                    self.rateViewModel.ratingCaptured(rating: ratingText)
                } else {
                    self.showAlertWithTextField("Invalid input. Please enter a value between 1 and 10.")
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the alert controller
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)

    }
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

