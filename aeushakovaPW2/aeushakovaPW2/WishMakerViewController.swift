//
//  WishMakerViewController.swift
//  aeushakovaPW2
//
//  Created by admin on 11.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    private enum Constants {
        static let titleFontSize: CGFloat = 32
        static let descriptionFontSize: CGFloat = 18
        static let leadingConstraint: CGFloat = 20
        static let topTitleConstraint: CGFloat = 30
        static let topDescriptionConstraint: CGFloat = 20
        static let bottomStackConstraint: CGFloat = -40
        static let stackCornerRadius: CGFloat = 20
        static let buttonCornerRadius: CGFloat = 10
        static let buttonShadowOpacity: Float = 0.3
        static let buttonShadowRadius: CGFloat = 5
    }
    
    private let titleView = UILabel()
    private let descriptionLabel = UILabel()
    private let sliderRed = CustomSlider(title: "Red", min: 0, max: 1)
    private let sliderBlue = CustomSlider(title: "Blue", min: 0, max: 1)
    private let sliderGreen = CustomSlider(title: "Green", min: 0, max: 1)
    private let toggleButton = UIButton()
    private let randomColorButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        configureTitle()
        configureDescription()
        configureSliders()
        configureToggleButton()
        configureRandomColorButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = "WishMaker"
        titleView.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .bold)
        titleView.textAlignment = .center
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topTitleConstraint),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingConstraint)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Make a wish and let the colors guide your dreams."
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.textColor = .white
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingConstraint),
            descriptionLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.topDescriptionConstraint)
        ])
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackCornerRadius
        stack.clipsToBounds = true
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingConstraint),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.bottomStackConstraint)
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self?.updateBackgroundColor()
        }
        sliderBlue.valueChanged = { [weak self] value in
            self?.updateBackgroundColor()
        }
        sliderGreen.valueChanged = { [weak self] value in
            self?.updateBackgroundColor()
        }
    }
    
    private func updateBackgroundColor() {
        let red = CGFloat(sliderRed.slider.value)
        let green = CGFloat(sliderGreen.slider.value)
        let blue = CGFloat(sliderBlue.slider.value)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func configureToggleButton() {
        configureButtonAppearance(toggleButton)
        toggleButton.setTitle("Toggle Sliders", for: .normal)
        toggleButton.addTarget(self, action: #selector(toggleSlidersVisibility), for: .touchUpInside)
        
        view.addSubview(toggleButton)
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureRandomColorButton() {
        configureButtonAppearance(randomColorButton)
        randomColorButton.setTitle("Random Color", for: .normal)
        randomColorButton.addTarget(self, action: #selector(setRandomBackgroundColor), for: .touchUpInside)
        
        view.addSubview(randomColorButton)
        NSLayoutConstraint.activate([
            randomColorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomColorButton.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 20)
        ])
    }
    
    private func configureButtonAppearance(_ button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = Constants.buttonShadowOpacity
        button.layer.shadowRadius = Constants.buttonShadowRadius
        
        // Эффект нажатия
        button.addTarget(self, action: #selector(handleButtonPress(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(handleButtonRelease(_:)), for: [.touchUpInside, .touchDragExit])
    }
    
    @objc private func handleButtonPress(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc private func handleButtonRelease(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    @objc private func toggleSlidersVisibility() {
        let sliders = [sliderRed, sliderBlue, sliderGreen]
        let areSlidersHidden = sliders.first?.isHidden ?? false
        sliders.forEach { $0.isHidden = !areSlidersHidden }
    }
    
    @objc private func setRandomBackgroundColor() {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
