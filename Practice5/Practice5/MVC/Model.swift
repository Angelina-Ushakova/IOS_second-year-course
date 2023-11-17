//
//  Model.swift
//  ArchitecturesShowcase
//
//  Created by Grigory Sosnovskiy on 17.11.2023.
//

enum MVCModel {
    struct Login {
        var username: String
        var email: String
        
        var name: String
        var lastName: String
        var middleName: String
        
        var fio: String {
            return lastName + name + middleName
        }
    }
    
    struct Start {
        
    }
}
