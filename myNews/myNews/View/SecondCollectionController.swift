//
//  SecondCollectionController.swift
//  myNews
//
//  Created by Pu Yue - PU YUE on 2022/06/30.
//

import Foundation
import UIKit

class SecondCollectionController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        
        let cell = UINib(nibName: "Cell", bundle: nil)
        self.collectionView.register(cell, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.updateData()
            self?.collectionView.reloadData()
            self?.collectionView.layoutIfNeeded()
        }
    }
    
    func updateData() {
        let viewModels = ViewModel.shared.allCellsViewModels.filter {
            if let cellViewModel = $0 as? CellViewModel,
               cellViewModel.isChecking {
                return true
            } else {
                return false
            }
        }
        ViewModel.shared.checkingViewModels = viewModels.map {
            $0 as! CellViewModel
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return  ViewModel.shared.checkingViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        cell.viewModel = ViewModel.shared.checkingViewModels[indexPath.item]
        return cell
    }
}

extension SecondCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - 60) / 2
        let cellHeight = cellWidth / (3 / 2) //keep aspect 3:2
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
