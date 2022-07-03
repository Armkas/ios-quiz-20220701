//
//  CellViewModelBase.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/29.
//

import Foundation

protocol CellViewModelBase {
    var title: String? { get set }
}

//让3种cellViewModel的父级都是这个 才能把3种cellViewModel写进一个数组
