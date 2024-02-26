//
//  Coordinator.swift
//  Movies Demo
//
//  Created by Rain on 2024.02.24.
//

import Foundation
import UIKit
protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func dismissModal()

}
