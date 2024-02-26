//
//  FavoriteButton.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class FavoriteButton: UIButton {
    var icon: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
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
        self.backgroundColor = .white
        icon = UIImageView()
        icon.image = UIImage(named: "favorite")
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.isUserInteractionEnabled = false
        icon.contentMode = .scaleAspectFit

        self.addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: 26.9),
            icon.widthAnchor.constraint(equalToConstant: 28.18)
        ])
    }
}
