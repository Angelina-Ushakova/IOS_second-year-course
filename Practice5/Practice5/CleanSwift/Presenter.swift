//
//  Presenter.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

protocol PresentationLogic: AnyObject {
    func presentStart()
}

final class Presenter: PresentationLogic {
    weak var viewController: DisplayLogic?
    
    func presentStart() {
        viewController?.displayStart()
    }
}
