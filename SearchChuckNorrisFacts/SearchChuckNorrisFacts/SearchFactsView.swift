//
//  SearchFactsView.swift
//  SearchChuckNorrisFacts
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
        view.text = "Find a random fact by category:"
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(categoriesTableView)
    }
}
