//
//  FactsListViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit

public protocol FactsListViewModelable {

    func showSearch()
}

public final class FactsListViewController: UIViewController {

    private let viewModel: FactsListViewModelable

    public init(viewModel: FactsListViewModelable) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        view.backgroundColor = .green
        viewModel.showSearch()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
