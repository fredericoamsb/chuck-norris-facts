//
//  FactsListViewController.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift

public protocol FactsListViewModelable {

    var facts: BehaviorSubject<[FactViewModel]> { get }
    func showSearch()
}

public final class FactsListViewController: UIViewController {

    // MARK: Instances
    private let viewModel: FactsListViewModelable
    private let factsListTableView = UITableView()
    private let disposeBag = DisposeBag()

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

        setupFactsListTableView()
    }

    private func setupFactsListTableView() {
        let cellIdentifier = "factListCell"
        factsListTableView.delegate = nil
        factsListTableView.dataSource = nil
        factsListTableView.separatorStyle = .none
        factsListTableView.bounces = false
        factsListTableView.register(FactListCell.self, forCellReuseIdentifier: cellIdentifier)

        viewModel.facts.bind(to: factsListTableView.rx.items(cellIdentifier: cellIdentifier, cellType: FactListCell.self)) {_, item, cell in
            cell.set(description: item.description, category: item.category)
        }.disposed(by: disposeBag)
    }

    @objc private func addTapped() {
        viewModel.showSearch()
    }
}
