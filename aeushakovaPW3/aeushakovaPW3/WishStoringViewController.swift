//
//  WishStoringViewController.swift
//  aeushakovaPW3
//
//  Created by admin on 11.11.2023.
//

import UIKit

// Этот контроллер управляет отображением списка желаний пользователя.
final class WishStoringViewController: UIViewController, UITableViewDataSource {
    // Вспомогательные константы для настройки интерфейса и ключа UserDefaults.
    private enum Constants {
        static let tableCornerRadius: CGFloat = 10.0
        static let tableOffset: CGFloat = 20.0
        static let numberOfSections: Int = 2
        static let wishesKey = "wishesKey"
    }
    
    // Экземпляр UserDefaults для сохранения массива желаний.
    private let defaults = UserDefaults.standard
    private var wishArray: [String] {
        didSet {
            // Сохранение массива желаний в UserDefaults при каждом изменении.
            defaults.set(wishArray, forKey: Constants.wishesKey)
        }
    }
    
    // Таблица для отображения желаний.
    private let table: UITableView = UITableView(frame: .zero)
    
    // Инициализатор класса.
    init() {
        // Извлечение сохранённых желаний из UserDefaults или инициализация пустым массивом.
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
        super.init(nibName: nil, bundle: nil)
        // Регистрация классов ячеек для таблицы.
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настройка представления после загрузки его представления.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // Установка цвета фона представления.
        setupTable()
    }
    
    // Метод настройки таблицы и её констрейнтов.
    private func setupTable() {
        view.addSubview(table) // Добавление таблицы на представление.
        table.dataSource = self // Назначение источника данных таблицы.
        table.translatesAutoresizingMaskIntoConstraints = false
        // Активация констрейнтов для позиционирования таблицы.
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.tableOffset),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.tableOffset)
        ])
        table.layer.cornerRadius = Constants.tableCornerRadius // Задание скругления углов таблицы.
        table.separatorStyle = .none // Удаление разделителей ячеек.
    }
    
    // MARK: - UITableViewDataSource
    // Количество секций в таблице.
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    // Количество ячеек в каждой секции.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // Секция для добавления нового желания.
        } else {
            return wishArray.count // Секция для отображения сохранённых желаний.
        }
    }
    
    // Конфигурация ячеек для каждой секции.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Ячейка для добавления нового желания.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as? AddWishCell else {
                return UITableViewCell()
            }
            cell.addButton.addTarget(self, action: #selector(addWish), for: .touchUpInside)
            return cell
        } else {
            // Ячейка для отображения существующего желания.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as? WrittenWishCell else {
                return UITableViewCell()
            }
            cell.configure(with: wishArray[indexPath.row])
            return cell
        }
    }
    
    // Обработчик нажатия на кнопку для добавления нового желания.
    @objc private func addWish(sender: UIButton) {
        if let cell = sender.superview?.superview as? AddWishCell,
           let newWish = cell.wishTextField.text, !newWish.isEmpty {
            // Добавление нового желания в массив и обновление таблицы.
            wishArray.append(newWish)
            table.insertRows(at: [IndexPath(row: wishArray.count - 1, section: 1)], with: .automatic)
            cell.wishTextField.text = "" // Очистка текстового поля.
            cell.wishTextField.resignFirstResponder() // Скрытие клавиатуры.
        }
    }
}
