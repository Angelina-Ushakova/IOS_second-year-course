//
//  WishStoringViewController.swift
//  aeushakovaPW3
//
//  Created by admin on 11.11.2023.
//

// Импортируем необходимые модули.
import UIKit

final class WishStoringViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Константы для настройки интерфейса.
    private enum Constants {
        static let tableCornerRadius: CGFloat = 10.0
        static let tableOffset: CGFloat = 20.0
        static let numberOfSections: Int = 2
        static let navigationBarHeight: CGFloat = 35.0 // Высота навигационной панели
        static let statusBarHeight: CGFloat = 5.0 // Высота статус-бара
        static let wishesKey = "wishesKey"
    }
    
    // Экземпляр UserDefaults для сохранения желаний.
    private let defaults = UserDefaults.standard
    
    // Массив для хранения желаний пользователя.
    private var wishArray: [String] {
        didSet {
            // Сохраняем желания в UserDefaults каждый раз при их изменении.
            defaults.set(wishArray, forKey: Constants.wishesKey)
        }
    }
    
    // Таблица для отображения желаний.
    private let table: UITableView = UITableView()
    
    // Инициализатор класса.
    init() {
        wishArray = defaults.object(forKey: Constants.wishesKey) as? [String] ?? []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод вызывается после загрузки представления контроллера.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTable()
    }
    
    // Конфигурация и добавление таблицы на представление.
    private func setupTable() {
        // Определение отступов учитывает навигационную панель и статус-бар.
        let topInset = Constants.navigationBarHeight + Constants.statusBarHeight + Constants.tableOffset
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.tableOffset),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.tableOffset),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.tableOffset)
        ])
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    // Настройка навигационной панели и кнопки "Назад".
    private func setupNavigation() {
        // Если navigationController не используется, добавляем кастомную навигационную панель.
        if self.navigationController == nil {
            let navigationBar = UINavigationBar()
            navigationBar.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(navigationBar)
            // Установка констрейнтов для навигационной панели.
            NSLayoutConstraint.activate([
                navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
                navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationBar.heightAnchor.constraint(equalToConstant: Constants.navigationBarHeight)
            ])
            
            let navigationItem = UINavigationItem(title: "Мои желания")
            navigationBar.setItems([navigationItem], animated: false)
            
            // Кнопка "Назад".
            let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        } else {
            // Если используется navigationController, настраиваем кнопку "Назад" в его navigationBar.
            navigationItem.title = "Мои желания"
            let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    @objc private func backButtonTapped() {
        // Проверяем, как представлен контроллер, и закрываем его соответствующим образом.
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    // Определяем количество секций в таблице.
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
    
    // Определяем количество строк в каждой секции.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // В первой секции одна строка для добавления нового желания.
            return 1
        } else {
            // Во второй секции столько строк, сколько желаний сохранено.
            return wishArray.count
        }
    }
    
    // Конфигурируем ячейки таблицы.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // Конфигурация ячейки для добавления нового желания.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId) as? AddWishCell else {
                return UITableViewCell()
            }
            cell.addButton.addTarget(self, action: #selector(addWish), for: .touchUpInside)
            return cell
        } else {
            // Конфигурация ячейки для отображения существующего желания.
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId) as? WrittenWishCell else {
                return UITableViewCell()
            }
            cell.configure(with: wishArray[indexPath.row])
            return cell
        }
    }
    
    // MARK: - UITableViewDelegate
    
    // Разрешаем редактирование строк во второй секции.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }
    
    // Обработка удаления строки с желанием.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            wishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Обработка выбора строки с желанием для редактирования.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            // Показываем диалоговое окно для редактирования выбранного желания.
            let alertController = UIAlertController(title: "Редактировать желание", message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = self.wishArray[indexPath.row]
            }
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { [unowned self] _ in
                if let newText = alertController.textFields?.first?.text {
                    self.wishArray[indexPath.row] = newText
                    tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
            alertController.addAction(saveAction)
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Обработчик нажатия на кнопку добавления нового желания.
    @objc private func addWish(sender: UIButton) {
        // Если текстовое поле не пустое, добавляем новое желание в массив и обновляем таблицу.
        if let cell = sender.superview?.superview as? AddWishCell,
           let newWish = cell.wishTextField.text, !newWish.isEmpty {
            wishArray.append(newWish)
            table.insertRows(at: [IndexPath(row: wishArray.count - 1, section: 1)], with: .automatic)
            cell.wishTextField.text = ""
            cell.wishTextField.resignFirstResponder()
        }
    }
}
