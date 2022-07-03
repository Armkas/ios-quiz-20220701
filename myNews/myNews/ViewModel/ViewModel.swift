//
//  ViewModel.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/27.
//

import Foundation
import UIKit

final class ViewModel {
    
    static let shared = ViewModel()
    
    var sections: [Section] = [] {
        didSet {
            for sec in sections {
                if let title = sec.title {//人気のトピック
                    let sectionViewModel = SectionCellViewModel.init(title: title)
                    allCellsViewModels.append(sectionViewModel)
                }
                for gro in sec.groups {
                    if let title = gro.title {//銀行
                        let itemViewModel = ItemCellViewModel.init(title: title)
                        allCellsViewModels.append(itemViewModel)
                    }
                    for hit in gro.hits {
                        let cellViewModel = CellViewModel.init(title: hit.label, followersCount: hit.followersCount)
                        allCellsViewModels.append(cellViewModel)
                    }
                }//这次cell之间不用嵌套，让所有cell都是cell级别，3次元的结构，变成1次元的数组allCellsViewModels，每个cell大小再分别设定
            }
        }
    }
    var allCellsViewModels: [CellViewModelBase] = []
    var checkingViewModels: [CellViewModel] = []
    
    func getData(_ completion: @escaping () -> Void) {
        Api.shared.getData { [weak self] sections, error in
            guard let self = self else { return }
            if let sections = sections {
                self.sections = sections
                completion()
            }
        }
    }
}
