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
    var isChecking = false//这里追加了一个flag通过这来判断，不能通过当前图片来判断
    
    init(title: String?, followersCount: Int?) {
        self.title = title
        self.followersCount = followersCount
    }
}
