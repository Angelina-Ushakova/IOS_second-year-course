//
//  Assembly.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

import UIKit


enum Assembly {
    static func build() -> UIViewController {
        let presenter = Presenter()
        let interactor = Interactor(presenter: presenter)
        let router = Router()
        let viewController = CSViewController(interactor: interactor, router: router)
        presenter.viewController = viewController as? any DisplayLogic
        router.viewController = viewController
        return viewController
    }
}
