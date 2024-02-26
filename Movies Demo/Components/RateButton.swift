//
//  RateButton.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit
enum RateButtonType:String{
    case rated
    case notRated
    case rating
}
class RateButton: UIButton {
    var type:RateButtonType!
    var topHalfView:UIView!
    var firstLabel: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 16)
        label.textColor = UIColor(hex: "FFFFFF", alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var secondLabel: UILabel = {
        let label = UILabel()
        label.font(.interBold, size: 12)
        label.textColor = UIColor(hex: "D7BA8E", alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
    private func setupViews() {
        self.backgroundColor = UIColor(hex: "000000", alpha: 1)
        
        let container = UIView()
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        container.backgroundColor = .black
        container.translatesAutoresizingMaskIntoConstraints = false
        container.isUserInteractionEnabled = false
        self.addSubview(container)
        
        topHalfView = UIView()
        topHalfView.backgroundColor = UIColor(hex: "AB803F", alpha: 1)
        topHalfView.translatesAutoresizingMaskIntoConstraints = false
        topHalfView.isUserInteractionEnabled = false
        container.addSubview(topHalfView)
        
        self.addSubview(firstLabel)
        self.addSubview(secondLabel)
        
        firstLabel.text = "Rate it myself >"
        secondLabel.text = "add personal rating"
        
        NSLayoutConstraint.activate([
            
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            topHalfView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topHalfView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topHalfView.topAnchor.constraint(equalTo: self.topAnchor),
            topHalfView.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            
            firstLabel.leadingAnchor.constraint(equalTo: topHalfView.leadingAnchor),
            firstLabel.trailingAnchor.constraint(equalTo: topHalfView.trailingAnchor),
            firstLabel.heightAnchor.constraint(equalTo: topHalfView.heightAnchor),
            firstLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            
            secondLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            secondLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            secondLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    func updateRateButtonAppearance(type:RateButtonType, rating:String?){
        self.type = type
        switch type {
        case .notRated:
            firstLabel.textColor = UIColor(hex: "FFFFFF", alpha: 1)
            firstLabel.font(.interRegular, size: 16)
            topHalfView.backgroundColor = UIColor(hex: "AB803F", alpha: 1)
            secondLabel.textColor = UIColor(hex: "D7BA8E", alpha: 1)
            firstLabel.text = "Rate it myself >"
            secondLabel.text = "add personal rating"
        case .rated:
            firstLabel.font(.interRegular, size: 11)
            
            let ratingString = rating ?? "-"
            let amountText = NSMutableAttributedString.init(string: "You've rated this  " + ratingString)
            amountText.setAttributes([NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 22)!],
                                     range: NSMakeRange(amountText.length-ratingString.count, ratingString.count))
            firstLabel.attributedText = amountText
            firstLabel.textColor = UIColor(hex: "FFFFFF", alpha: 1)
            topHalfView.backgroundColor = UIColor(hex: "6FAB3F", alpha: 1)
            secondLabel.textColor = UIColor(hex: "6FAB3F", alpha: 1)
//            firstLabel.text = "You've rated this"
            secondLabel.text = "click to reset"
        case .rating:
            firstLabel.font(.interRegular, size: 16)
            firstLabel.font(.interRegular, size: 16)
            topHalfView.backgroundColor = UIColor(hex: "FFF3D3", alpha: 1)
            firstLabel.textColor = UIColor(hex: "B98E1E", alpha: 1)
            secondLabel.textColor = UIColor(hex: "B98E1E", alpha: 1)
            firstLabel.text = "Rating now"
            secondLabel.text = "using modal"
        }
        
    }
}
