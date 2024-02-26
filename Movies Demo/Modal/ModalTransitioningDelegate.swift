//
//  ModalTransitioningDelegate.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit

class ModalTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

