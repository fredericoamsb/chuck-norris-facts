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

public class SearchFactsViewController: UIViewController {

    private let viewModel: SearchFactsViewModelable

    public init(viewModel: SearchFactsViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func loadView() {
        view = UIView()
        view.backgroundColor = .green
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

    }
}
