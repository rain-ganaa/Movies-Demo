//
//  CurvedImageView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class CurvedImageView: UIView {
    var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topRight], radius: 30.0, borderWidth: 5, borderColor: .white)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        imageView = UIImageView()
//        imageView.layer.borderWidth = 5.0
//        imageView.layer.borderColor = UIColor.white.cgColor
//        layer.borderWidth = 5.0
//        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 162),
            imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // Apply curved corner to the top-right corner of the image view
        let maskPath = UIBezierPath(roundedRect: imageView.bounds,
                                    byRoundingCorners: [.topRight],
                                    cornerRadii: CGSize(width: 30.0, height: 0.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
//        layer.mask = maskLayer
        layer.masksToBounds = true
        
        contentMode = .scaleAspectFit
    }
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        // Create shape layer for the border
        let borderLayer = CAShapeLayer()
        borderLayer.path = path.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth * 2
        layer.addSublayer(borderLayer)

    }
}
