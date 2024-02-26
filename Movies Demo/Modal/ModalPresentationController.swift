//
//  ModalPresentationController.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.26.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    override var shouldRemovePresentersView: Bool {
        return true
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
}
