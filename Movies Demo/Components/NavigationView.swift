//
//  NavigationView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class NavigationView: BaseView {
    var backgroundView: UIView = {
        let backgroundView = UIView()
//        backgroundView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.3)

        return backgroundView
    }()
    public var backButton: BackButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    func setupViews(){
        backgroundView = UIView(frame: self.bounds)
        self.addSubview(backgroundView)
        
        backButton = BackButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isEnabled = true
        self.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:34),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 26),
        ])
    }
    func setButtonTintColor(_ color:UIColor){
        backButton.label.textColor = color
        backButton.icon.tintColor = color
    }
    func setBackButtonTitle(_ text:String){
        backButton.label.text = text
    }
    func setBackgroundColor(_ color:UIColor){
        backgroundView.backgroundColor = color
    }
}
