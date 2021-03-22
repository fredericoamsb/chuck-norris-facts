//
//  SearchFactsViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit

public protocol SearchFactsViewModelable {

    func searchFact()
}

public final class SearchFactsViewController: UISearchContainerViewController {

    private let viewModel: SearchFactsViewModelable

    public init(viewModel: SearchFactsViewModelable) {
        self.viewModel = viewModel

        let searchController = UISearchController()
        searchController.searchBar.showsCancelButton = true
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search for facts"
        searchController.hidesNavigationBarDuringPresentation = false

        super.init(searchController: searchController)

        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func loadView() {
        view = SearchFactsView()
    }
}
