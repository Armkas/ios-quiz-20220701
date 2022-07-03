//
//  ItemCell.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/29.
//

import Foundation
import UIKit

class ItemCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    var viewModel: ItemCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            if let title = viewModel.title {
                self.title.text = title
            }
        }
    }
}
