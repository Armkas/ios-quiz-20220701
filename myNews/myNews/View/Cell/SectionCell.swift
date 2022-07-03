//
//  SectionCell.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/29.
//

import Foundation
import UIKit

class SectionCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    var viewModel: SectionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            if let title = viewModel.title {
                self.title.text = title
            }
        }
    }
}
