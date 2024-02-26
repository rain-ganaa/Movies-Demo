//
//  RateViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

//
//  RateViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit

class RateViewController: ChildViewController {
    var thumbnailView:ThumbnailView!
    var contentsView:UIView!
    var rateButton:RateButton!
    var favsButton:TextButton!
    var rateViewModel:RateViewModel!
    var didClosed : (() -> ()) = {}
    override func viewDidDisappear(_ animated: Bool) {
        self.didClosed()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigation(true)
        navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationBar.setBackButtonTitle("Back")
        navigationBar.setButtonTintColor(UIColor(hex: "FFFFFF", alpha: 1))
        navigationBar.backgroundColor = .clear
        // Do any additional setup after loading the view.
        
        self.view.bringSubviewToFront(scrollView)
        self.view.bringSubviewToFront(navigationBar)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.removeFromSuperview()
        self.view.addSubview(titleLabel)

        titleLabel.textColor = UIColor(hex: "FFFFFF", alpha: 1)
        setupContentsView()
        callRateViewModel()
    }
    func callRateViewModel(){
        self.updateUI()
        self.rateViewModel.bindDeleteRating = { status, reason in
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
    }
    func updateUI(){
        self.rateViewModel.setupContents(backgroundImageView: backgroundImage,title: titleLabel, thumbnailView: thumbnailView)
        DispatchQueue.main.async {
            self.rateViewModel.setRated(button: self.rateButton)
        }
        
    }
    func setupContentsView() {
        titleLabel.textColor = UIColor(hex: "FFFFFF", alpha: 1)
        titleLabel.numberOfLines = 2
        titleLabel.adjustsFontSizeToFitWidth = true

        contentsView = UIView()
        contentsView.backgroundColor = UIColor(hex: "A5E8B4", alpha: 1)
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentsView)
        
        thumbnailView = ThumbnailView()
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(thumbnailView)
        
        rateButton = RateButton()
        rateButton.translatesAutoresizingMaskIntoConstraints = false
        rateButton.addTarget(self, action: #selector(rateButtonTapped), for: .touchUpInside)
        contentsView.addSubview(rateButton)
        
        let label: UILabel = {
            let label = UILabel()
            label.font(.jomhuria, size: 30)
            label.textColor = UIColor(hex: "FFFFFF", alpha: 1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "You rated this"
            return label
        }()
        self.view?.addSubview(label)
        contentsView.addSubview(rateButton)
        
        favsButton = TextButton()
        favsButton.translatesAutoresizingMaskIntoConstraints = false
        favsButton.addTarget(self, action: #selector(favsButtonTapped), for: .touchUpInside)
        favsButton.setLabel(backgroundColor: UIColor(hex: "FFFFFF", alpha: 1), textColor: UIColor(hex: "000000", alpha: 1), text: "Go to favourites")
        contentsView.addSubview(favsButton)

        
        NSLayoutConstraint.activate([
            
            backgroundImage.bottomAnchor.constraint(equalTo: self.view.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:32),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-32),
            titleLabel.heightAnchor.constraint(equalToConstant: 96),
            titleLabel.topAnchor.constraint(equalTo: self.navigationBar.backButton.bottomAnchor, constant:18),
            
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 30),
            
            contentsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentsView.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            contentsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            //            contentsView.heightAnchor.constraint(equalToConstant: 300),
            thumbnailView.topAnchor.constraint(equalTo: contentsView.topAnchor, constant: -145),
            thumbnailView.thumbImageView.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor),
            
            rateButton.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant:27),
            rateButton.centerXAnchor.constraint(equalTo: contentsView.centerXAnchor),
            rateButton.widthAnchor.constraint(equalToConstant: 150),
            rateButton.heightAnchor.constraint(equalToConstant: 56),
            
            favsButton.topAnchor.constraint(equalTo: rateButton.bottomAnchor, constant:21),
            favsButton.leadingAnchor.constraint(equalTo: contentsView.leadingAnchor, constant: 50),
            favsButton.trailingAnchor.constraint(equalTo: contentsView.trailingAnchor, constant: -50),
            favsButton.heightAnchor.constraint(equalToConstant: 56)

        ])
    }
    @objc func favsButtonTapped() {
//        coordinator?.showFavorite(self.fav)
    }
    @objc func rateButtonTapped() {
        self.rateViewModel.unrateCatured()
    }
}
