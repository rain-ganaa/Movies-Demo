//
//  ChildViewController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class ChildViewController: BaseViewController {
    var backgroundImage:UIImageView!
    var backgroundTransparentView:UIView!
    var titleLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        self.view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        backgroundTransparentView = UIView(frame: self.view.bounds)
        backgroundTransparentView.backgroundColor = .black
        backgroundTransparentView.alpha = 0.8
        self.view.addSubview(backgroundTransparentView)
        self.view.bringSubviewToFront(self.navigationBar)
        
        titleLabel = UILabel()
        titleLabel.font(.jomhuria, size: 96)
//        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.numberOfLines = 0
        self.scrollView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant:32),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:-32),
//            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 96)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
