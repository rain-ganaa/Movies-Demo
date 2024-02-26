//
//  BaseView.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.25.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
extension BaseView{
    func font(_ name:Fonts, size:CGFloat) -> UIFont{
        return UIFont(name: name.rawValue, size: size)!
    }
}
