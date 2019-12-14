//
//  TicTacToeGridCell.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/15.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import UIKit

class TicTacToeGridCell: UICollectionViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    static let reuseIdentifier = "TicTacToeGridCell"
    //static let rowHeight: CGFloat = <#Row Height#>
    static var nib: UINib {
        return UINib(nibName: "TicTacToeGridCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView = UIView()
        backgroundView?.backgroundColor = .systemBlue
    }
}
