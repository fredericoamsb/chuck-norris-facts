//
//  SearchFactsViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import RxSwift

public protocol SearchFactsViewModelable {

    func backToList()
    func searchFact(query: String)
}

public final class SearchFactsViewController: UISearchContainerViewController {

    private let viewModel: SearchFactsViewModelable
    private let disposeBag = DisposeBag()

    public init(viewModel: SearchFactsViewModelable) {
        self.viewModel = viewModel

        let searchController = UISearchController()
        searchController.searchBar.showsCancelButton = true
        let searchBar = searchController.searchBar
        searchBar.placeholder = L10n.SearchFacts.SearchBar.placeholder
        searchController.hidesNavigationBarDuringPresentation = false

        super.init(searchController: searchController)

        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false

        searchBar.rx.cancelButtonClicked.bind {
            viewModel.backToList()
        }.disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked.bind {
            viewModel.searchFact(query: searchBar.text ?? "")
        }.disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func loadView() {
        view = SearchFactsView()
    }
}
