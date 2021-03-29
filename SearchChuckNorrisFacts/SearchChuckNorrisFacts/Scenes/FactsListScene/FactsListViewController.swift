//
//  FactsListViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

public final class FactsListViewController: UIViewController {

    // MARK: Instances
    public let viewModel: FactsListViewModelable
    private let factsListTableView = UITableView()
    private let cellIdentifier = "factListCell"
    private let disposeBag = DisposeBag()

    private lazy var searchButton = ({
        return UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
    })()

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
        navigationItem.rightBarButtonItem = searchButton

        setupFactsListTableView()
        setupBindings()
    }

    private func setupFactsListTableView() {
        factsListTableView.separatorStyle = .none
        factsListTableView.bounces = false
        factsListTableView.register(FactListCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    private func setupBindings() {
        viewModel.facts.bind(to: factsListTableView.rx.items(cellIdentifier: cellIdentifier, cellType: FactListCell.self)) { _, fact, cell in
            cell.set(description: fact.description, category: fact.category)
//            cell.shareButton.rx.tap
//                .map { fact }
//                .bind(to: viewModel.factShareButtonAction)
//                .disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)

        searchButton.rx.tap
            .bind(to: viewModel.searchAction)
            .disposed(by: disposeBag)
    }
}
