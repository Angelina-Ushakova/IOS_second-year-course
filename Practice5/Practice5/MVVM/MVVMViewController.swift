//
//  MVVMViewController.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

import UIKit

final class MVVMViewController: UIViewController {
    private var viewModel: ViewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewController = self
        //viewModel.login(model: MVVMModel.Login(username: <#T##String#>, email: <#T##String#>, name: <#T##String#>, lastName: <#T##String#>, middleName: <#T##String#>))
    }
    
    func showUsername(_ username: String) {
        // show username
    }
}
