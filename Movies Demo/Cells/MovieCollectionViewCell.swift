//
//  MovieCollectionViewCell.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import Foundation
import UIKit
class MovieCollectionViewCell: UICollectionViewCell {
    var buttonActionHandler: (() -> Void)?
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .blue
        return imageView
    }()
    var favoriteButton:FavoriteButton = {
        let button = FavoriteButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.icon.image = UIImage(named: "starClicked")

        return button
    }()
    var ratingLabel:UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 16)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var ratingValueLabel:UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 20)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        contentView.addSubview(thumbnail)
        contentView.addSubview(favoriteButton)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(ratingValueLabel)
            
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnail.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnail.widthAnchor.constraint(equalToConstant: 120),
            thumbnail.heightAnchor.constraint(equalToConstant: 162),
            
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: thumbnail.bottomAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 48),
            favoriteButton.heightAnchor.constraint(equalToConstant: 48),
            
            ratingLabel.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant:13),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingLabel.heightAnchor.constraint(equalToConstant: 18),
            
            ratingValueLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant:12),
            ratingValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratingValueLabel.heightAnchor.constraint(equalToConstant: 18),
            ratingValueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        favoriteButton.layer.shadowColor = UIColor.black.cgColor
        favoriteButton.layer.shadowOpacity = 0.8
        favoriteButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        favoriteButton.layer.shadowRadius = 4
        favoriteButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

    }
    @objc func buttonTapped(_ sender: UIButton) {
        buttonActionHandler?()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure the cell with data
    func configure(withTitle title: String) {
        // Configure other UI components with data as needed
    }
}
