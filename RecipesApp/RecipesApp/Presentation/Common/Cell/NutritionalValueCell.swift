//
//  NutritionalValueTableViewCell.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import Foundation
import UIKit

class NutritionalValueTableViewCell: UITableViewCell {

    private enum Dimensions {
        static let inset: CGFloat = 20
        static let offset: CGFloat = 10
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let valueNutrionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    var name: String? {
        didSet {
            guard let name = name else { return }
            titleLabel.text = name
        }
    }
    
    var valueNutrion: String? {
        didSet {
            guard let valueNutrion = valueNutrion else { return }
            valueNutrionLabel.text = valueNutrion + " гр."
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.Base.background
        selectionStyle = .none

        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueNutrionLabel)
    }
    
    private func setupConstraints() {
        valueNutrionLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Dimensions.inset)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(Dimensions.offset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(Dimensions.inset)
            $0.centerY.equalToSuperview()
        }
    }
}
