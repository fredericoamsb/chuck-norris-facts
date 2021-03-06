//
//  FactsListViewController.swift
//  Facts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

public final class FactsListViewController: UIViewController {

    // MARK: Instances
    private let viewModel: FactsListViewModelable
    let factsListTableView = UITableView()
    private let cellIdentifier = "factListCell"
    private let disposeBag = DisposeBag()

    lazy var searchButton: UIBarButtonItem = ({
        let barButton = UIBarButtonItem(barButtonSystemItem: .search, target: nil, action: nil)
        barButton.accessibilityIdentifier = "searchButton"
        return barButton
    })()

    private lazy var loadingView: UIActivityIndicatorView = ({
        let view = UIActivityIndicatorView()
        view.accessibilityIdentifier = "factsListLoadingView"
        view.style = .large
        return view
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

        self.title = L10n.FactsList.title
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.prefersLargeTitles = true

        setupBindings()

        setupFactsListTableView()
        setupLoadingIndicator()
    }

    private func setupLoadingIndicator() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        let navigationBarHeight = navigationController?.navigationBar.bounds.height ?? 0
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -(navigationBarHeight + statusBarHeight)/2).isActive = true
    }

    private func setupFactsListTableView() {
        factsListTableView.accessibilityIdentifier = "factsListTableView"
        factsListTableView.separatorStyle = .none
        factsListTableView.register(FactListCell.self, forCellReuseIdentifier: cellIdentifier)
        let headerAndFooter = UIView()
        headerAndFooter.translatesAutoresizingMaskIntoConstraints = false
        headerAndFooter.heightAnchor.constraint(equalToConstant: 8).isActive = true
        factsListTableView.tableHeaderView = headerAndFooter
        factsListTableView.tableFooterView = headerAndFooter
    }

    private func setupBindings() {
        viewModel.facts.bind(to: factsListTableView.rx.items(cellIdentifier: cellIdentifier,
                                                             cellType: FactListCell.self)) { [weak self] _, fact, cell in
            guard let self = self else {
                return
            }
            cell.set(description: fact.description, category: fact.category)
            cell.shareButton.rx.tap
                .map { fact }
                .bind(to: self.viewModel.factShareButtonAction)
                .disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)

        viewModel.errorAction.bind { [weak self] errorMessage in
            let alert = UIAlertController(title: L10n.FactsList.Alert.title, message: errorMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: L10n.FactsList.Alert.button, style: .default)
            alert.addAction(action)
            self?.present(alert, animated: true)
        }.disposed(by: disposeBag)

        searchButton.rx.tap
            .bind(to: viewModel.searchAction)
            .disposed(by: disposeBag)

        viewModel.isLoading
            .bind(to: loadingView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
