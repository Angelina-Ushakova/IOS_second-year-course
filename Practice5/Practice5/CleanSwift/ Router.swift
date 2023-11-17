//
//  Router.swift
//  ArchitecturesShowcase
//
//  Created by admin on 17.11.2023.
//

import UIKit

protocol RoutingLogic {
    func goToStart()
}

class Router: RoutingLogic {
    weak var viewController: CSViewController?
    
    func goToStart() {
        let mvcViewController = MVCViewController()
        viewController?.present(mvcViewController, animated: false)
    }
}
