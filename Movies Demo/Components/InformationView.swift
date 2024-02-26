//
//  MovieInformation.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//
import UIKit
class InformationView:BaseView{
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
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 12)
        label.textColor = UIColor(hex: "959595", alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.font(.interBold, size: 20)
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
    var percentView:PercentageView!
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        self.addSubview(descLabel)
        self.addSubview(ratingLabel)
        self.addSubview(userScoreLabel)
        self.addSubview(genreLabel)
        
        percentView = PercentageView()
        percentView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(percentView)
        
        NSLayoutConstraint.activate([
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            descLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            genreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            genreLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 15),
//            ratingLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            userScoreLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 18),
            userScoreLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor),
            userScoreLabel.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            
            percentView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            percentView.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant:3),
            percentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            percentView.heightAnchor.constraint(equalToConstant: 4),
            percentView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
}
