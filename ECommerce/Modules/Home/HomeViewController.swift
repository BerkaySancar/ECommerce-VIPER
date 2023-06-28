//
//  HomeViewController.swift
//  ECommerce
//
//  Created by Berkay Sancar on 27.06.2023.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    
}

final class HomeViewController: UIViewController {
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    internal var presenter: HomePresenterInputs!
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

// MARK: - HomeView protocols
extension HomeViewController: HomeViewProtocol {
    
}

// MARK: - Collection View Delegates
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

