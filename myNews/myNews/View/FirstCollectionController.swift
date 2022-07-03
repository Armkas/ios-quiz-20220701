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
        
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        
        let sectionCell = UINib(nibName: "SectionCell", bundle: nil)
        self.collectionView.register(sectionCell, forCellWithReuseIdentifier: "SectionCell")
        
        let itemCell = UINib(nibName: "ItemCell", bundle: nil)
        self.collectionView.register(itemCell, forCellWithReuseIdentifier: "ItemCell")
        
        let cell = UINib(nibName: "Cell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "Cell")
        
        ViewModel.shared.getData { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
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
        switch cellViewModel {
        case is SectionCellViewModel:
            return CGSize(width: collectionView.bounds.size.width, height: 40)
        case is ItemCellViewModel:
            return CGSize(width: collectionView.bounds.size.width, height: 30)
        default:
            let cellWidth = (collectionView.bounds.size.width - 60) / 2
            let cellHeight = cellWidth / (3 / 2) //keep aspect 3:2
            return CGSize(width: cellWidth, height: cellHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

