//
//  FactListCell.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift

final class FactListCell: UITableViewCell {

    // MARK: Subviews
    lazy var containerView: UIStackView = ({
        let stackView = UIStackView()
        stackView.layer.cornerRadius = 8
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.systemGray.cgColor
        return stackView
    })()

    lazy var containerStackView: UIStackView = ({
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    })()

    lazy var footerStackView: UIStackView = ({
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    })()

    lazy var infoLabel: UILabel = ({
        let label = UILabel()
        label.numberOfLines = 0
        return label
    })()

    lazy var categoryView: UIView = ({
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        return view
    })()

    lazy var categotyLabel: UILabel = ({
        let label = UILabel()
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    })()

    lazy var shareButton: UIButton = ({
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.up")
        button.setImage(image, for: .normal)
        return button
    })()

    // MARK: Instances
    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
        super.prepareForReuse()
    }

    private func setupUI() {
        selectionStyle = .none

        addSubview(containerView)
        containerView.addSubview(containerStackView)

        let padding: CGFloat = 16
        containerView.fillSuperview(padding: UIEdgeInsets(top: padding/2, left: padding,
                                                               bottom: padding/2, right: padding))

        containerStackView.fillSuperview(padding: UIEdgeInsets(top: padding, left: padding,
                                                               bottom: padding, right: padding))

        containerStackView.addArrangedSubview(infoLabel)
        containerStackView.addArrangedSubview(footerStackView)

        footerStackView.addArrangedSubview(categoryView)
        footerStackView.addArrangedSubview(shareButton)

        let verticalPadding: CGFloat = 2
        let horizontalPadding: CGFloat = 8
        categoryView.addSubview(categotyLabel)
        categotyLabel.fillSuperview(padding: UIEdgeInsets(top: verticalPadding, left: horizontalPadding,
                                                          bottom: verticalPadding, right: horizontalPadding))
    }

    func set(description: String, category: String?) {
        infoLabel.text = description
        infoLabel.font = description.count > 80 ? UIFont.preferredFont(forTextStyle: .title2) :
            UIFont.preferredFont(forTextStyle: .title1)
        categotyLabel.text = category == nil ? L10n.FactCell.Category.uncategorized : category
    }
}
