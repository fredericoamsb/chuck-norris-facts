//
//  SearchFactsViewController.swift
//  Facts
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import RxSwift

public final class SearchFactsViewController: UISearchContainerViewController {

    let viewModel: SearchFactsViewModelable
    private let disposeBag = DisposeBag()

    public init(viewModel: SearchFactsViewModelable) {
        self.viewModel = viewModel

        let searchController = UISearchController()
        searchController.searchBar.showsCancelButton = true
        let searchBar = searchController.searchBar
        searchBar.accessibilityIdentifier = "searchBar"
        searchBar.placeholder = L10n.SearchFacts.SearchBar.placeholder
        searchController.hidesNavigationBarDuringPresentation = false

        super.init(searchController: searchController)

        navigationItem.titleView = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false

        searchBar.rx.cancelButtonClicked
            .bind(to: viewModel.cancelAction)
            .disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .map { (searchBar.text ?? "") }
            .bind(to: viewModel.searchAction)
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func loadView() {
        view = SearchFactsView()
        view.accessibilityIdentifier = "searchFactsView"
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
}
