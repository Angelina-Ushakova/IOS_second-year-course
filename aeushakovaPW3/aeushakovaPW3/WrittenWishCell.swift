//
//  WrittenWishCell.swift
//  aeushakovaPW3
//
//  Created by admin on 11.11.2023.
//

import UIKit

// Этот класс является кастомной ячейкой для отображения желаний в списке.
final class WrittenWishCell: UITableViewCell {
    static let reuseId = "WrittenWishCell"
    
    // Эти константы задают параметры внешнего вида ячейки.
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
    }
    
    // Метка для отображения текста желания.
    private let wishLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Здесь можно настроить внешний вид метки.
        return label
    }()
    
    // Инициализатор ячейки.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Метод для конфигурации содержимого ячейки с переданным желанием.
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // Метод для настройки UI элементов в ячейке.
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap = UIView()
        wrap.translatesAutoresizingMaskIntoConstraints = false
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        contentView.addSubview(wrap)
        wrap.pinVertical(to: contentView, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: contentView, Constants.wrapOffsetH)
        
        wrap.addSubview(wishLabel)
        NSLayoutConstraint.activate([
            wishLabel.topAnchor.constraint(equalTo: wrap.topAnchor, constant: Constants.wishLabelOffset),
            wishLabel.bottomAnchor.constraint(equalTo: wrap.bottomAnchor, constant: -Constants.wishLabelOffset),
            wishLabel.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.wishLabelOffset),
            wishLabel.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -Constants.wishLabelOffset)
        ])
    }
}
