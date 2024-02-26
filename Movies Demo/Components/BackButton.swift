//
//  BackButton.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class BackButton: UIButton {
    var label: UILabel!
    var icon: UIImageView!
    var backgroundView:UIView!
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.layer.cornerRadius = self.frame.size.height/2
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

        backgroundView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        backgroundView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.3)
        backgroundView.layer.cornerRadius = self.frame.size.height/2
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.masksToBounds = true
        backgroundView.isUserInteractionEnabled = false
        self.addSubview(backgroundView)
        
        icon = UIImageView()
        icon.image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = false
        self.addSubview(icon)
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font(.interRegular, size: 10)
        label.numberOfLines = 1
        label.isUserInteractionEnabled = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 10),
            icon.widthAnchor.constraint(equalToConstant: 6),

            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -24),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)

        ])
        self.autoresizingMask = [.flexibleWidth]
    }
}
