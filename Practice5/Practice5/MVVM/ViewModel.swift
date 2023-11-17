//
//  ViewModel.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

final class ViewModel {
    weak var viewController: MVVMViewController?
    
    func login(model: MVVMModel.Login) {
        print(model.username)
        
        viewController?.showUsername(model.username)
    }
}
