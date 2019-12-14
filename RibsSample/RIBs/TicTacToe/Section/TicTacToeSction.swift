//
//  TicTacToeSction.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/15.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

enum TicTacToeSection: Int {
    case grid
    
    var numberOfItems: Int {
        switch self {
        case .grid:
            return 9
        }
    }
    
    var layout: NSCollectionLayoutSection {
        switch self {
        case .grid:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            group.interItemSpacing = .fixed(8)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}
