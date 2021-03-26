//
//  FactListCell.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit

final class FactListCell: UITableViewCell {

   lazy var info: UILabel = ({
       let label = UILabel()
       label.text = "Description here"
       return label
   })()

   lazy var categoty: UILabel = ({
       let label = UILabel()
       label.text = "UNCATEGORIZED"
       return label
   })()

    func set(description: String) {
        textLabel?.text = description
    }
}
