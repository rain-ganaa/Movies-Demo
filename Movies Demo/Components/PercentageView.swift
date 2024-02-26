//
//  PercentagView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import Foundation
import UIKit
class PercentageView:BaseView{
    var percentageConstraint:NSLayoutConstraint!
    let percentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "4CAB4A", alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        self.backgroundColor = UIColor(hex: "D2D2D2", alpha: 1)
        self.addSubview(percentView)
        
        NSLayoutConstraint.activate([
            percentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            percentView.topAnchor.constraint(equalTo: self.topAnchor),
            percentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func setPercent(_ percent:CGFloat){
        percentageConstraint = percentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier:percent)
        percentageConstraint.isActive = true

    }
}
