//
//  MovieTableViewCell.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font(.interBold, size: 16)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descLabel: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 12)
        label.textColor = UIColor(hex: "959595", alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font(.interBold, size: 12)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let userScoreLabel: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 12)
        label.textColor = UIColor(hex: "000000", alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if(highlighted){
            UIView.animate(withDuration: 0.1) {
                self.contentView.alpha = 0.3
            }
        }else{
            UIView.animate(withDuration: 0.1) {
                self.contentView.alpha = 1
            }
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    private func setupViews() {
        contentView.addSubview(thumbnail)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descLabel)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(userScoreLabel)
        NSLayoutConstraint.activate([
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configs.contentMargin),
            thumbnail.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            thumbnail.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            thumbnail.widthAnchor.constraint(equalToConstant: Configs.thumbnailWidth),
            thumbnail.heightAnchor.constraint(equalToConstant: Configs.thumbnailHeight), // Set the fixed height
            
            containerView.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 27),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configs.contentMargin),
            containerView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 5),
            ratingLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            userScoreLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 7),
            userScoreLabel.trailingAnchor.constraint(greaterThanOrEqualTo: containerView.trailingAnchor),
            userScoreLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnail.image = nil
    }
}

