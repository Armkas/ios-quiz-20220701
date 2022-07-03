//
//  CellViewModel.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/29.
//

import Foundation

class CellViewModel: CellViewModelBase {
    var title: String?
    var followersCount: Int?
    var isChecking = false
    
    init(title: String?, followersCount: Int?) {
        self.title = title
        self.followersCount = followersCount
    }
}
