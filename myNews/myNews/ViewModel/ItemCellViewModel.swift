//
//  ItemCellViewModel.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/29.
//

import Foundation

class ItemCellViewModel: CellViewModelBase {
    var title: String?
    
    init(title: String) {
        self.title = title
    }
}
