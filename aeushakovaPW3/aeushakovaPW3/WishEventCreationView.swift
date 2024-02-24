//
//  WishEventCreationView.swift
//  aeushakovaPW3
//
//  Created by admin on 14.02.2024.
//

import UIKit

class WishEventCreationView: UIViewController {
    
    private let eventNameTextField = UITextField()
    private let eventDescriptionTextField = UITextField()
    private let startDateTextField = UITextField()
    private let endDateTextField = UITextField()
    private let saveEventButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
    }
    
    var onSave: ((WishEventModel) -> Void)?

    @objc private func saveEvent() {
        // Создание объекта события из введенных данных
        let event = WishEventModel(title: eventNameTextField.text ?? "",
                                   description: eventDescriptionTextField.text ?? "",
                                   startDate: startDateTextField.text ?? "",
                                   endDate: endDateTextField.text ?? "")
        onSave?(event)
        dismiss(animated: true)
    }
    
    private func setupViews() {
        eventNameTextField.placeholder = "Название события"
        eventDescriptionTextField.placeholder = "Описание события"
        startDateTextField.placeholder = "Дата начала"
        endDateTextField.placeholder = "Дата окончания"
        
        [eventNameTextField, eventDescriptionTextField, startDateTextField, endDateTextField].forEach {
            $0.borderStyle = .roundedRect
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        saveEventButton.setTitle("Сохранить", for: .normal)
        saveEventButton.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        saveEventButton.backgroundColor = .blue
        saveEventButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [eventNameTextField, eventDescriptionTextField, startDateTextField, endDateTextField, saveEventButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.backgroundColor = .white.withAlphaComponent(0.9)
    }
    
}
