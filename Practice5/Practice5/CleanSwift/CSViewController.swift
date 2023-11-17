//
//  CSViewController.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

import UIKit

protocol DisplayLogic: AnyObject {
    func displayStart()
}

class CSViewController: UIViewController {
    var interactor: BusinessLogic
    var router: RoutingLogic?
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        init(interactor: BusinessLogic, router: RoutingLogic) {
            self.interactor = interactor
            self.router = router
            super.init(nibName: nil, bundle: nil)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadStart()
    }
}

// MARK: - DisplayLogic
extension CSViewController {
    func displayStart() {
        print("hello")
        router?.goToStart()
    }
}
