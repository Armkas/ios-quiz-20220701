//
//  Cell.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/26.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    var viewModel: CellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            self.title.text = viewModel.title
            if let followersCount = viewModel.followersCount {
                self.text.text = "\(followersCount) 人がフォロー"
            }
            updateCheckMark()
        }
    }
    
    func updateCheckMark() {
        guard let viewModel = viewModel else { return }
        let isChecking = viewModel.isChecking
        self.checkMark.image = isChecking ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
}
