//
//  WishEventCell.swift
//  aeushakovaPW3
//
//  Created by admin on 5.02.2024.
//

import UIKit

struct WishEventModel {
    var title: String
    var description: String
    var startDate: String
    var endDate: String
}

class WishEventCell: UICollectionViewCell {
    static let reuseIdentifier = "WishEventCell"
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .white
        static let titleFont: UIFont = .boldSystemFont(ofSize: 20)
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let dateFont: UIFont = .systemFont(ofSize: 12)
        static let textColor: UIColor = .black
        static let offset: CGFloat = 5
        static let interItemSpacing: CGFloat = 5
    }
    
    private let wrapView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.titleFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.descriptionFont
        label.textColor = Constants.textColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dateFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let endDateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dateFont
        label.textColor = Constants.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(wrapView)
        [titleLabel, descriptionLabel, startDateLabel, endDateLabel].forEach {
            wrapView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.offset),
            wrapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.offset),
            wrapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.offset),
            wrapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.offset),
            
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.offset),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.offset),
            titleLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.offset),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.interItemSpacing),
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.offset),
            descriptionLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.offset),
            
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.interItemSpacing),
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.offset),
            startDateLabel.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -Constants.offset),
            
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: Constants.interItemSpacing),
            endDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.offset),
            endDateLabel.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -Constants.offset)
        ])
    }
    
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
}
