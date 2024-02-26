//
//  ThumbnailView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class ThumbnailView: BaseView {
    var favoriteButton:FavoriteButton!
    var thumbImageView:CurvedImageView!
    var thumbnailImageTopConstraint:NSLayoutConstraint!
    var thumbnailImageTrailingConstraint:NSLayoutConstraint!
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    func setupViews(){
        thumbImageView = CurvedImageView()
        thumbImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbImageView.imageView.contentMode = .scaleAspectFill
        self.addSubview(thumbImageView)
        
        favoriteButton = FavoriteButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favoriteButton)
        
        thumbnailImageTopConstraint = thumbImageView.topAnchor.constraint(equalTo: favoriteButton.icon.bottomAnchor, constant: -5)
        thumbnailImageTrailingConstraint = thumbImageView.trailingAnchor.constraint(equalTo: favoriteButton.icon.leadingAnchor, constant: -0.91)
        thumbnailImageTopConstraint.isActive = true
        thumbnailImageTrailingConstraint.isActive = true

        NSLayoutConstraint.activate([
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:0),
            favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant:0),
            favoriteButton.heightAnchor.constraint(equalToConstant: 48),
            favoriteButton.widthAnchor.constraint(equalToConstant: 48),
            thumbImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            thumbImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

