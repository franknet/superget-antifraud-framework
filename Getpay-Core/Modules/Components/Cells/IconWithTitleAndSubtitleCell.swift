//
//  IconWithTitleAndSubtitleCell.swift
//  Getpay-Core
//
//  Created by Marcus Vinicius Grussner on 09/03/21.
//  Copyright © 2021 Getnet. All rights reserved.
//

import UIKit

public final class IconWithTitleAndSubtitleCell: UITableViewCell {
    
    // MARK: - Internal variables
    
    public static let identifier = String(describing: IconWithTitleAndSubtitleCell.self)
    
    // MARK: - Private variables
    
    private let wrapperStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.spacing = 16.0
        $0.alignment = .top
        return $0
    } (UIStackView())
    
    private let contentStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4.0
        return $0
    } (UIStackView())
    
    private lazy var icon: UIImageView = {
        $0.tintColor = GPColors.homer.color
        return $0
    }(UIImageView())
    
    private lazy var title = GPLabel(font: FontFamily.Calibri.bold,
                                     fontSize: 16.0,
                                     textColor: GPColors.edna.color)
    
    private lazy var subTitle = GPLabel(textColor: GPColors.flanders.color)
    
    // MARK: - Initializers
    
    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
        selectionStyle = .none
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IconWithTitleAndSubtitleCell {
    
    // MARK: - Public methods
    
    public func configure(icon: UIImage, title: String, subTitle: String) {
        self.icon.image = icon
        self.title.text = title
        self.subTitle.text = subTitle
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addComponents()
        setupIcon()
        setupContainerStack()
    }
    
    private func addComponents() {
        contentView.addSubview(wrapperStack, constraints: true)
        
        wrapperStack.addArrangedSubview(icon)
        wrapperStack.addArrangedSubview(contentStack)
        
        contentStack.addArrangedSubview(title)
        contentStack.addArrangedSubview(subTitle)
    }
    
    private func setupIcon() {
        icon.width(size: 24.0)
        icon.height(size: 24.0)
    }
    
    private func setupContainerStack() {
        NSLayoutConstraint.activate([
            wrapperStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            wrapperStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            wrapperStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            wrapperStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0)
        ])
    }
}

