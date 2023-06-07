//
//  NavigationCoordinator.swift
//  Netomi_To-Do
//
//  Created by SPURGE on 06/06/23.
//

import UIKit

final class NavCoordinator {
    
    // MARK: - Properties
    
    private let navigationController = UINavigationController()
    
    var rootViewController: UINavigationController {
        return navigationController
    }
    
    // MARK: - Methods
     func showRootview() {
        let controller = DependencyInjector.rootViewController
        navigationController.pushViewController(controller, animated: true)
    }
    
}
