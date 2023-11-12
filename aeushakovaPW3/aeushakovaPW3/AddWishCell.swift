//
//  AddWishCell.swift
//  aeushakovaPW3
//
//  Created by admin on 11.11.2023.
//

import UIKit

// Я создаю кастомную ячейку для добавления новых желаний.
final class AddWishCell: UITableViewCell {
    static let reuseId = "AddWishCell"
    
    // Текстовое поле, в которое я буду вводить желания.
    let wishTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите ваше желание"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // Кнопка, нажатие на которую будет добавлять желание в список.
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Добавить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Здесь я настраиваю расположение элементов внутри ячейки.
    private func setupLayout() {
        contentView.addSubview(wishTextField)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            wishTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            wishTextField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10),
            wishTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

