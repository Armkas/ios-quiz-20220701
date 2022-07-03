//
//  FirstCollectionController.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/30.
//

import Foundation
import UIKit

class FirstCollectionController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)//CollectionViewController 只能设定内部cell之间的距离关系， cell整体和外部的关系这里
        
        let sectionCell = UINib(nibName: "SectionCell", bundle: nil)
        self.collectionView.register(sectionCell, forCellWithReuseIdentifier: "SectionCell")
        
        let itemCell = UINib(nibName: "ItemCell", bundle: nil)
        self.collectionView.register(itemCell, forCellWithReuseIdentifier: "ItemCell")
        
        let cell = UINib(nibName: "Cell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "Cell")
        
        ViewModel.shared.getData { [weak self] in
            DispatchQueue.main.async { [weak self] in//主线程
                self?.collectionView.reloadData()//一旦执行触发numberOfSections & numberOfItemsInSection 重新告诉OS有多少个cell
                self?.collectionView.layoutIfNeeded()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            self?.collectionView.layoutIfNeeded()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return  ViewModel.shared.allCellsViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //使用view
        guard !ViewModel.shared.allCellsViewModels.isEmpty else { return UICollectionViewCell() }
        let cellViewModel = ViewModel.shared.allCellsViewModels[indexPath.item]
        switch cellViewModel {
        case is SectionCellViewModel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as! SectionCell
            let viewModel = cellViewModel as! SectionCellViewModel
            cell.viewModel = viewModel
            return cell
        case is ItemCellViewModel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
            let viewModel = cellViewModel as! ItemCellViewModel
            cell.viewModel = viewModel
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
            let viewModel = cellViewModel as! CellViewModel
            cell.viewModel = viewModel
            return cell
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? Cell,
              let cellViewModel = cell.viewModel
        else { return }
        cellViewModel.isChecking = !cellViewModel.isChecking
        cell.updateCheckMark()
    }
    
}

extension FirstCollectionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !ViewModel.shared.allCellsViewModels.isEmpty else { return CGSize.zero }
        let cellViewModel = ViewModel.shared.allCellsViewModels[indexPath.item]
        switch cellViewModel {//3种cellViewModel分别设定尺寸
        case is SectionCellViewModel:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        case is ItemCellViewModel:
            return CGSize(width: collectionView.bounds.size.width, height: 30)
        default:
            let cellWidth = (collectionView.bounds.size.width - 60) / 2
            let cellHeight = cellWidth / (3 / 2)
            return CGSize(width: cellWidth, height: cellHeight)
            /*这里有个注意点，假如页面宽100，中间间隔20,2个cell，那么每个cell宽度必须小于40否则UI会崩溃。
             1. 各个组件的边界可能有1px的宽度
             2.CGFlout是有小数点的， 系统后台做除法会省略掉余数 3.5/3 = 1
             所以要预留宽度 具体留多少 要再看
             */
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10//2行之间最小距离
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10//同行2cell之间最小距离
    }
}

