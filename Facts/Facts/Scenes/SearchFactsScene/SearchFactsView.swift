//
//  SearchFactsView.swift
//  Facts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit

final class SearchFactsView: UIView {

    lazy var stackView: UIStackView = ({
        let view = UIStackView()
        view.axis = .vertical
        return view
    })()

    lazy var headerView: UILabel = ({
        let view = UILabel()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.text = L10n.SearchFacts.Label.header
        view.textColor = .systemBlue
        view.backgroundColor = .systemBackground
        view.textAlignment = .center
        return view
    })()

    lazy var categoriesTableView: UITableView = ({
        let tableView = UITableView()
        tableView.bounces = false
        return tableView
    })()

    override func layoutSubviews() {
        super.layoutSubviews()

        setupUI()
    }

    private func setupUI() {
        addSubview(stackView)
        stackView.fillSuperview(padding: UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0))
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(categoriesTableView)
    }
}
