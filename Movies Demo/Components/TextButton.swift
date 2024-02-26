//
//  FavsButton.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class TextButton: UIButton {
    var label: UILabel = {
        let label = UILabel()
        label.font(.interRegular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.height/2
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
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    func setLabel(backgroundColor: UIColor, textColor:UIColor, text:String){
        self.backgroundColor = backgroundColor
        label.textColor = textColor
        label.text = text

    }
}
