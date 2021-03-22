//
//  FactsListViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift

public protocol FactsListViewModelable {

    func showSearch()
}

public final class FactsListViewController: UIViewController {

    private let viewModel: FactsListViewModelable
    private let factsListTableView = FactsListTableView()

    public init(viewModel: FactsListViewModelable) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func loadView() {
        view = factsListTableView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = L10n.FactsList.title
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = searchButton

//        factsListTableView.rx.
    }

    @objc private func addTapped() {
        viewModel.showSearch()
    }
}
