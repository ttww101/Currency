//
//  LLCatalogCollectionView.swift
//  FoodSearch
//
//  Created by jacky wang on 2019/1/22.
//  Copyright © 2019 Banset Timsry. All rights reserved.
//

import UIKit

final class LLCatalogCollectionView: UICollectionView {
    
    var didSelectItem: ((_ index: LLCatalogModel) -> ())?
    
    private let identifier = "identifier"

    private var contents: [LLCatalogModel] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, contents: [LLCatalogModel], cellSize: CGSize) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = cellSize
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.minimumInteritemSpacing = 0.0
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.contents = contents
        setup()
    }
    
    private func setup() {
        register(LLCatalogCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        isScrollEnabled = false
        backgroundColor = .white
        delegate = self
        dataSource = self
    }
}

// ******************************************
//
// MARK: - UICollectionViewDelegate
//
// ******************************************
extension LLCatalogCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelectItem?(contents[indexPath.row])
    }
}

// ******************************************
//
// MARK: - UICollectionViewDataSource
//
// ******************************************
extension LLCatalogCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! LLCatalogCollectionViewCell
        cell.lblDescription.text = contents[indexPath.row].description
        cell.img.image = contents[indexPath.row].icon
        return cell
    }
}


