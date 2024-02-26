//
//  HeaderView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import Foundation
import UIKit
class HeaderView:BaseView{
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = Configs.searchBarHeight/2
        searchBar.clipsToBounds = true
        searchBar.backgroundColor = UIColor(hex: "FFFFFF", alpha: 1)
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.backgroundColor = UIColor(hex: "FFFFFF", alpha: 1)
        searchBar.setImage(UIImage(named:"clear"), for: .clear, state: .normal)
        return searchBar
    }()
    var label: UILabel = {
        let label = UILabel()
        label.font(.jomhuria, size: 60)
        label.textColor = UIColor(hex: "347868", alpha: 1)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var container:UIView! = nil
    var searchBarTopConstraint:NSLayoutConstraint!
    var searchBarBottomConstraint:NSLayoutConstraint!
    var searchBarLeadingConstraint:NSLayoutConstraint!
    var searchBarTrailingConstraint:NSLayoutConstraint!
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
    
    func setupViews(){
        container = UIView()
        self.addSubview(container)
        container.addSubview(searchBar)
        container.addSubview(label)
        container.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "8EEAA2",alpha: 1)
        searchBar.searchTextField.font = font(.interBold, size: 16)
        searchBar.searchTextField.textColor = UIColor(hex: "000000", alpha: 1)
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(hex: "000000", alpha: 1),
                                                                    .font: font(.interBold, size: 16)]
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)
        searchBar.searchTextField.attributedPlaceholder = attributedPlaceholder

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            searchBar.heightAnchor.constraint(equalToConstant: Configs.searchBarHeight),

            label.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 37),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 31),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 22),
            label.heightAnchor.constraint(equalToConstant: 49),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -27)
        ])
        searchBarTopConstraint = searchBar.topAnchor.constraint(equalTo: container.topAnchor, constant: 57)
        searchBarTopConstraint.isActive = true
        
        searchBarLeadingConstraint = searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Configs.searchBarMargin)
        searchBarLeadingConstraint.isActive = true
        
        searchBarTrailingConstraint = searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Configs.searchBarMargin)
        searchBarTrailingConstraint.isActive = true
        
        searchBarBottomConstraint = searchBar.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        searchBarBottomConstraint.isActive = false
        
        self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
    }
    func shrink(_ shrink:Bool){
        label.isHidden = shrink
        searchBarBottomConstraint.isActive = shrink
        searchBarLeadingConstraint.constant = shrink ? 0:Configs.searchBarMargin
        searchBarTrailingConstraint.constant = shrink ? 0:-Configs.searchBarMargin
    }
}
