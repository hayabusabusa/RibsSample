//
//  TicTacToeViewController.swift
//  RibsSample
//
//  Created by 山田隼也 on 2019/12/14.
//  Copyright © 2019 Shunya Yamada. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol TicTacToePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TicTacToeViewController: UIViewController, TicTacToePresentable, TicTacToeViewControllable {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    weak var listener: TicTacToePresentableListener?
    private var dataSource: [TicTacToeSection] = [.grid]
    
    // MARK: Lifecycle
    
    static func instantiate() -> TicTacToeViewController {
        let vc = Storyboard.TicTacToeViewController.instantiate(TicTacToeViewController.self)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - Setup

extension TicTacToeViewController {
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(setupCollectionViewLayout(), animated: false)
        collectionView.register(TicTacToeGridCell.nib, forCellWithReuseIdentifier: TicTacToeGridCell.reuseIdentifier)
    }
    
    private func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            guard let section = TicTacToeSection(rawValue: section) else { return nil }
            return section.layout
        }
        return layout
    }
}

extension TicTacToeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section] {
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicTacToeGridCell.reuseIdentifier, for: indexPath) as! TicTacToeGridCell
            return cell
        }
    }
}
