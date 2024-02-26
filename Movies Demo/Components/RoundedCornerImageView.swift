//
//  RoundedCornerImageView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

import UIKit

class RoundedCornerImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        // Set the image (replace "placeholderImage" with your actual image)
        image = UIImage(named: "placeholderImage") // Set your image here
        
        // Set corner radius for the top-right corner
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight],
                                cornerRadii: CGSize(width: 30.0, height: 0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
        
        // Ensure that content mode is set appropriately
        contentMode = .scaleAspectFill
    }
}
