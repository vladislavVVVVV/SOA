//
//  MenueTableViewCell.swift
//  RecipesApp
//
//  Created by Mac on 4/11/21.
//

import UIKit

class MenueTableViewCell: UITableViewCell {

    private enum Dimensions {
        static let inset: CGFloat = 20
        static let offset: CGFloat = 10
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()

    var menue: Menu? {
        didSet {
            guard let menue = menue else { return }
            titleLabel.text = menue.name
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
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
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(Dimensions.inset)
            $0.leading.equalToSuperview().inset(Dimensions.offset)
            $0.centerY.equalToSuperview()
        }
    }
}
